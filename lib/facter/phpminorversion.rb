Facter.add('phpminorversion') do
  confine :kernel => 'Linux'
  setcode do
    if File.file?('/usr/bin/php')
      Facter::Core::Execution.exec('/usr/bin/php -r "echo PHP_MINOR_VERSION;"')
    end  
  end
end