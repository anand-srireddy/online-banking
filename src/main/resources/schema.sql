drop database if exists OnlineBanking;
create database OnlineBanking;

use OnlineBanking;

drop table if exists users;
drop table if exists transactions;

create table users (
                       firstName VARCHAR(30) not null,
                       lastName varchar(30) not null,
                       gender    VARCHAR(1) not null,
                       email varchar(35) not null,
                       contact varchar(15) not null,
                       accountType    VARCHAR(10) not null,
                       username VARCHAR(30) not null,
                       password  VARCHAR(30) not null,
                       accountNumber int not null AUTO_INCREMENT,
                       primary key (accountNumber)
);

ALTER TABLE users AUTO_INCREMENT=21100542;

create table account (
                         accountNumber int not null,
                         username VARCHAR(30) not null,
                         amount decimal(12,3) not null,
                         accountType    VARCHAR(10) not null,
                         CONSTRAINT account_num_fk FOREIGN KEY(accountNumber) REFERENCES users(accountNumber)

);

create table transactions (
                              transactionid int not null AUTO_INCREMENT,
                              transactiondate varchar(30) not null,
                              accountNumber int not null,
                              accountType    VARCHAR(10) not null,
                              transactionType varchar(10) not null,
                              amount decimal(12,3) not null,
                              primary key (transactionid)
);

ALTER TABLE transactions AUTO_INCREMENT=513460;

