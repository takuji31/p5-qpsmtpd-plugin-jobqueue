use inc::Module::Install;
name 'Qpsmtpd-Plugin-JobQueue';
all_from 'lib/Qpsmtpd/Plugin/JobQueue.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
build_requires 'Test::LoadAllModules';
use_test_base;
auto_include;
WriteAll;
