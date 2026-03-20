create database game_shop;
use game_shop;

create table clients(
    client_id int primary key auto_increment,
    name_ varchar(255),
    address varchar(255),
    phone varchar(255),
    birthday date
);

create table roles(
    role_id int primary key auto_increment,
    name_ enum('manager','cashier','inventory_clerk','support')
);

create table branches(
    branch_id int primary key auto_increment,
    name_ varchar(255),
    address varchar(255),
    phone varchar(255),
    email varchar(255)
);

create table suppliers(
    supplier_id int primary key auto_increment,
    name_ varchar(255),
    address varchar(255),
    phone varchar(255),
    email varchar(255)
);

create table clasifications(
    clasification_id int primary key auto_increment,
    des enum('EC','E','E10+','T','M','AO','RP') not null default 'RP'
);

create table consoles(
    console_id int primary key auto_increment,
    name_ varchar(255)
);

create table paymethods(
    paymethod_id int primary key auto_increment,
    des enum('cash','credit_card','debit_card','transfer') not null
);

create table departments(
    department_id int primary key auto_increment,
    des varchar(255),
    branch_id int,
    foreign key (branch_id) references branches(branch_id)
);

create table games(
    game_id int primary key auto_increment,
    name_ varchar(255),
    des varchar(255),
    developer varchar(255),
    clasification_id int,
    console_id int,
    foreign key (clasification_id) references clasifications(clasification_id),
    foreign key (console_id) references consoles(console_id)
);

create table employees(
    employee_id int primary key auto_increment,
    name_ varchar(255),
    address varchar(255),
    phone varchar(255),
    email varchar(255),
    department_id int,
    role_id int,
    birthday date,
    contract_day date,
    foreign key (department_id) references departments(department_id),
    foreign key (role_id) references roles(role_id)
);

create table products(
    product_id int primary key auto_increment,
    product_type enum('game','console','accessory') not null,
    name_ varchar(255),
    des varchar(255),
    price float not null,
    console_id int,
    game_id int,
    foreign key (console_id) references consoles(console_id),
    foreign key (game_id) references games(game_id)
);

create table inventory(
    inventory_id int primary key auto_increment,
    product_id int,
    stock int default 0,
    supplier_id int,
    branch_id int,
    foreign key (product_id) references products(product_id),
    foreign key (supplier_id) references suppliers(supplier_id),
    foreign key (branch_id) references branches(branch_id)
);

create table sales_order(
    sale_id int primary key auto_increment,
    employee_id int,
    client_id int,
    paymethod_id int,
    date_ date,
    total float,
    foreign key (employee_id) references employees(employee_id),
    foreign key (client_id) references clients(client_id),
    foreign key (paymethod_id) references paymethods(paymethod_id)
);

create table order_details(
    order_detail_id int primary key auto_increment,
    sale_id int,
    product_id int,
    quantity int not null default 1,
    unit_price float,
    foreign key (sale_id) references sales_order(sale_id),
    foreign key (product_id) references products(product_id)
);

create table audit_log(
    log_id int primary key auto_increment,
    log_date datetime,
    log_user varchar(255),
    log_table varchar(255),
    operation varchar(50)
);


