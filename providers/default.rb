# Support whyrun
def whyrun_supported?
  true
end

action :install do
  set_default_attributes

  user(new_resource.user) do
    comment       new_resource.name.capitalize
    home          new_resource.home
    shell         "/bin/bash"
    supports      :manage_home => true
  end

  directory(@new_resource.clone_path) do
    recursive true
  end

  repo = git(new_resource.name) do
    repository    new_resource.repository
    revision      new_resource.revision
    destination   new_resource.clone_path
    action        :sync
    notifies      :run, "bash[compile #{new_resource.name}]", :immediately
  end

  new_resource.updated_by_last_action(repo.updated_by_last_action?)

  src_directory = ::File.join(new_resource.clone_path, 'src')
  conf_file = ::File.join(new_resource.home, "#{new_resource.name}.conf")

  bash "compile #{new_resource.name}" do
    code          "make -f makefile.unix clean; make -f makefile.unix USE_UPNP= #{new_resource.executable}"
    cwd           src_directory
    action        :nothing
    notifies      :run, "bash[strip #{new_resource.name}]", :immediately
  end

  bash "strip #{new_resource.name}" do
    code          "strip #{new_resource.executable}"
    cwd           src_directory
    action        :nothing
  end

  file ::File.join(new_resource.clone_path, 'src', new_resource.executable) do
    owner         new_resource.user
    group         new_resource.group
    mode          0500
  end

  link ::File.join(new_resource.home, new_resource.executable) do
    to            ::File.join(new_resource.clone_path, 'src', new_resource.executable)
    owner         new_resource.user
    group         new_resource.group
  end

  directory new_resource.data_dir do
    owner         new_resource.user
    group         new_resource.group
    mode          0700
  end

  file conf_file do
    owner         new_resource.user
    group         new_resource.group
    mode          0400
    content       config_content
  end

  template "/etc/init/#{new_resource.executable}.conf" do
    source        "upstart.conf.erb"
    mode          0700
    cookbook      "crypto-coin"
    variables(
      :user => new_resource.user,
      :group => new_resource.group,
      :data_dir => new_resource.data_dir,
      :conf_path => conf_file,
      :executable_name => new_resource.executable,
      :executable_path => ::File.join(new_resource.home, new_resource.executable)
    )
  end
end

def set_default_attributes
  @new_resource.user(@new_resource.user || @new_resource.name)
  @new_resource.group(@new_resource.group || @new_resource.name)
  @new_resource.home(@new_resource.home || ::File.join('/home', @new_resource.name))
  @new_resource.executable(@new_resource.executable || "#{@new_resource.name}d")
  @new_resource.clone_path(@new_resource.clone_path || ::File.join('/opt', 'crypto_coins', @new_resource.name))
  @new_resource.data_dir(@new_resource.data_dir || ::File.join(@new_resource.home, 'data'))
end

def config_hash
  @new_resource.conf['rpcpassword'] = @new_resource.rpcpassword
  @new_resource.conf['rpcport'] = @new_resource.rpcport
  @new_resource.conf['port'] = @new_resource.port

  # Connect to IRC for peer discovery
  @new_resource.conf['irc'] = 1
  # Set rpc user is "{coin}_user"
  @new_resource.conf['rpcuser'] = "#{@new_resource.name}_user"
  return @new_resource.conf
end

def config_content
  content = ""
  config_hash.each do |key, value|
    case value
    when Array
      value.each do |part|
        content << "#{key}=#{part}\n"
      end
    when NilClass
      # do nothing
    else
      content << "#{key}=#{value}\n"
    end
  end
  return content
end
