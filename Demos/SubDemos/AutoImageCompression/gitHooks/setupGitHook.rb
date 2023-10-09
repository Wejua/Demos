#!/usr/bin/ruby
require "Fileutils"

# 获取.git所在目录
git_path = `git rev-parse --git-dir`; git_path = git_path.strip;
# 获取当前文件所在目录
cur_path = `printf $(cd '#{git_path}'; cd ..; pwd)/gitHooks`; cur_path = cur_path.strip;
puts "gitPath:#{git_path}"
puts "cur_path:#{cur_path}"
# .git目录下没有hooks文件夹时新建一个
if Dir.exist?("#{git_path}/hooks") == false
  FileUtils.mkpath("#{git_path}/hooks")
end
# 将当前文件夹中pre-commit文件拷贝到.git/hooks目录下
FileUtils.cp("#{cur_path}/pre-commit", "#{git_path}/hooks/pre-commit")