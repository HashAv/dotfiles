#!/usr/bin/env ruby

require 'fileutils'
require 'digest'
require 'find'

include FileUtils

# Oops digest is dum since everything is symlinked
# Upon file change, I cannot pull without creating a git conflict
def digest_file(path)
  Digest::MD5.hexdigest(File.read(path))
end

def digest_dir(path)
  digests = []
  path += "/" if !path.end_with?('/') # Important for path (don't stop on the symlink)
  Find.find(path) do |p|
    next if File.directory?(p)
    digests << digest_file(p)
  end
  digests
end

def to_path(path, remove_from_final_path)
  File.join(HOME, path.sub(remove_from_final_path, ''))
end

def ensure_file_is_symlinked(from_path, to_path)
  if File.exist?(to_path)
    if File.symlink?(to_path)
      # Not to self: wanted to digest here, useless
      puts "Exists  : #{to_path}"
    else
      print "\033[1;31mWarning  ! \033[1;m"
      print "\033[47;30m#{to_path}\033[1;m is not a symlink! "
      puts "Remove or backup this file before running this scripts again"
    end
  else
    if File.symlink?(to_path)
      print "\033[1;31mBroken symlink  ! \033[1;m"
      print "\033[47;30m#{to_path}\033[1;m remove and run again! \n"
      return
    end
    ln_s(from_path, to_path)
    print "\033[1;32mCreated : \033[1;m"
    puts "\033[47;30m#{to_path}\033[1;m"
  end

end

def digest(path)
  if File.file?(path)
    return digest_file(path)
  elsif File.directory?(path)
    return digest_dir(path)
  else
    fail "Should handle file: #{path}"
  end
end

HOME = ENV['HOME']

basename_only_path = File.join(Dir.pwd, './symlink_basename_only') # full path is important later for symlinks
Find.find(basename_only_path).each do |path|
  next if path == basename_only_path

  ensure_file_is_symlinked(path, to_path(path,basename_only_path))
  Find.prune
end

symlink_every_file_path = File.join(Dir.pwd, './symlink_every_file') # full path is important later for symlink
Find.find(symlink_every_file_path).each do |path|
  next if path == symlink_every_file_path

  if File.directory?(path)
    to_dir_path = to_path(path, symlink_every_file_path)
    if !Dir.exist?(to_dir_path)
      abort("\033[1;31mMust create dir:\033[1;m #{to_dir_path}")
    end
  elsif File.file?(path)
    ensure_file_is_symlinked(path, to_path(path, symlink_every_file_path))
  else
    fail "Unknown file type for path: '#{path}'"
  end
end

puts
unless File.exist?("#{HOME}/.vim/bundle/Vundle.vim")
  puts "\033[1;31mVundle is not installed\033[1;m"
  puts "Please run the following commands"
  puts %Q_git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim_
  puts %Q_vim ; :PluginInstall_
end

  puts <<EOS
YouCompleteMe:
--------------

apt-get install build-essential cmake python-dev python3-dev curl

apt-get install nodejs npm # for javascript completion
apt-get install rustc cargo # for rust completion (super slow install)

cd ~/.vim/bundle/YouCompleteMe/ && ./install.py --go-completer --rust-completer --js-completer --java-completer
EOS
