# Support whyrun
def whyrun_supported?
  true
end

action :install do
  set_default_attributes

  user(@new_resource.user) do
    comment       @new_resource.name.capitalize
    home          @new_resource.home
    shell         "/bin/bash"
    supports      :manage_home => true
  end

  repo = git(@new_resource.name) do
    repository    @new_resource.repository
    revision      @new_resource.revision
    destination   @new_resource.clone_path
    action        :sync
    notifies      :run, "bash[compile #{@new_resource.name}]", :immediately
  end

  new_resource.updated_by_last_action(repo.updated_by_last_action?)

  bash "compile #{@new_resource.name}" do
    code          "make -f makefile.unix clean; make -f makefile.unix USE_UPNP= #{@new_resource.executable}"
    cwd           File.join(@new_resource.clone_path, 'src')
    # action        :nothing
    notifies      :run, "bash[strip #{@new_resource.name}]", :immediately
  end
end

def set_default_attributes
  @new_resource.user        ||= @new_resource.name
  @new_resource.group       ||= @new_resource.name
  @new_resource.home        ||= File.join('/home', @new_resource.name)
  @new_resource.executable  ||= "#{@new_resource.name}d"
  @new_resource.clone_path  ||= File.join('/opt', 'crypto_coins', @new_resource.name)
  @new_resource.data_dir    ||= File.join(@new_resource.home, 'data')
end
