Facter.add('phpextensiondir') do
  confine :kernel => 'Linux'
  setcode do
    if File.file?('/usr/bin/php')
      Facter::Core::Execution.exec('/usr/bin/php -i | grep "^extension_dir" | awk \'{print $5}\'')
    end
  end
end