#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'CatShop';
all_from 'lib/CatShop.pm';

requires 'Catalyst::Runtime' => '5.90062';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Model::DBIC::Schema';

requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::Any::YAML';
requires 'YAML::XS';

test_requires 'Test::More';

#install_script glob('script/*.pl');
auto_install;
WriteAll;
