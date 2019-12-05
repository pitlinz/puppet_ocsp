Facter.add('phpmajorversion') do
  confine :kernel => 'Linux'
  setcode do
    if File.file?('/usr/bin/php')
      Facter::Core::Execution.exec('/usr/bin/php -r "echo PHP_MAJOR_VERSION;"')
    end
  end
end