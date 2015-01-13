#!/usr/bin/env perl
use inc::Module::Install;

name 'CatShop';
all_from 'lib/CatShop.pm';

requires 'Catalyst::Runtime' => '5.90082';
requires 'Catalyst::View::TT';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';

requires 'Config::Any::YAML';
requires 'YAML::XS';
requires 'Config::ZOMG';

requires 'Plack::Builder';
requires 'Plack::Middleware::Static';
requires 'Carp';
requires 'Data::Dumper::Concise';

requires 'DBD::Pg';
requires 'DBIx::Class';
requires 'DBIx::Class::Schema::Loader';
requires 'MooseX::NonMoose';
requires 'Catalyst::Model::DBIC::Schema';
requires 'DBIx::Class::TimeStamp';
requires 'DateTime::Format::Pg';
requires 'DBIx::Class::InflateColumn::Authen::Passphrase';
requires 'DBIx::Class::MaterializedPath';
requires 'DBIx::Class::DynamicDefault';

requires 'App::Sqitch';

test_requires 'Test::More';

auto_install;
WriteAll;
