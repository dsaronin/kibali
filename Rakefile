require "bundler/gem_tasks"

# ------------------------------------------------------------------------
# don't use normal Rake test routine because of double factory_girl
# ------------------------------------------------------------------------
task :test do
   ruby '-I test "test/test_kibali.rb"'
   ruby '-I test "test/test_access.rb"'
   ruby '-I test "test/test_anon.rb"'
end # test task

task :default => :test

