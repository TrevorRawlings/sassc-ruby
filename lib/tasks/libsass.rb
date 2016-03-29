namespace :libsass do
  desc "Compile libsass"
  task :compile do
    if Dir.pwd.end_with?('/ext')
      libsass_path = "libsass"
    else
      libsass_path = "ext/libsass"
    end

    cd libsass_path do
      Rake::Task["lib/libsass.so"].invoke
    end
  end

  file "Makefile" do
    Dir.chdir(File.expand_path(File.dirname(__FILE__)) + '/../../') do
      sh "git submodule update --init"
    end
  end

  file "lib/libsass.so" => "Makefile" do
    sh 'make lib/libsass.so'
  end
end
