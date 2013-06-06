actions :install
default_action :install

attribute :name,            :kind_of => String, :name_attribute => true, :required => true
attribute :user,            :kind_of => String
attribute :group,           :kind_of => String
attribute :home,            :kind_of => String
attribute :executable,      :kind_of => String
attribute :clone_path,      :kind_of => String
attribute :data_dir,        :kind_of => String
attribute :conf,            :kind_of => Hash, :default => {}

attribute :repository,      :kind_of => String, :required => true
attribute :revision,        :kind_of => String, :default => 'master'

attribute :rpcpassword,    :kind_of => String, :required => true
attribute :rpcport,        :kind_of => Integer
attribute :port,            :kind_of => Integer, :required => true

attr_accessor :exists