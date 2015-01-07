#!/usr/bin/env perl
use inc::Module::Install;

name 'CatShop';
all_from 'lib/CatShop.pm';

requires 'Catalyst::Runtime' => '5.90062';
requires 'Catalyst::View::TT';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::Any::YAML';
requires 'YAML::XS';
requires 'Plack::Builder';
requires 'Plack::Middleware::Static';
requires 'Carp';
requires 'Data::Dumper::Concise';
requires 'DBIx::Class::Schema::Loader';

test_requires 'Test::More';

auto_install;
WriteAll;
