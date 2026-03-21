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
-- -----------------Triggers-------------------
delimiter $$

create trigger insert_aud_suppliers
after insert on suppliers for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'suppliers', 'insert');
end$$

create trigger update_aud_suppliers
before update on suppliers for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'suppliers', 'update');
end$$

create trigger delete_aud_suppliers
after delete on suppliers for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'suppliers', 'delete');
end$$


create trigger insert_aud_inventory
after insert on inventory for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'inventory', 'insert');
end$$

create trigger update_aud_inventory
before update on inventory for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'inventory', 'update');
end$$

create trigger delete_aud_inventory
after delete on inventory for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'inventory', 'delete');
end$$


create trigger insert_aud_roles
after insert on roles for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'roles', 'insert');
end$$

create trigger update_aud_roles
before update on roles for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'roles', 'update');
end$$

create trigger delete_aud_roles
after delete on roles for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'roles', 'delete');
end$$


create trigger insert_aud_employees
after insert on employees for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'employees', 'insert');
end$$

create trigger update_aud_employees
before update on employees for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'employees', 'update');
end$$

create trigger delete_aud_employees
after delete on employees for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'employees', 'delete');
end$$


create trigger insert_aud_departments
after insert on departments for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'departments', 'insert');
end$$

create trigger update_aud_departments
before update on departments for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'departments', 'update');
end$$

create trigger delete_aud_departments
after delete on departments for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'departments', 'delete');
end$$


create trigger insert_aud_clients
after insert on clients for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'clients', 'insert');
end$$

create trigger update_aud_clients
before update on clients for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'clients', 'update');
end$$

create trigger delete_aud_clients
after delete on clients for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'clients', 'delete');
end$$


create trigger insert_aud_paymethods
after insert on paymethods for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'paymethods', 'insert');
end$$

create trigger update_aud_paymethods
before update on paymethods for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'paymethods', 'update');
end$$

create trigger delete_aud_paymethods
after delete on paymethods for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'paymethods', 'delete');
end$$


create trigger insert_aud_branches
after insert on branches for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'branches', 'insert');
end$$

create trigger update_aud_branches
before update on branches for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'branches', 'update');
end$$

create trigger delete_aud_branches
after delete on branches for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'branches', 'delete');
end$$


create trigger insert_aud_clasifications
after insert on clasifications for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'clasifications', 'insert');
end$$

create trigger update_aud_clasifications
before update on clasifications for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'clasifications', 'update');
end$$

create trigger delete_aud_clasifications
after delete on clasifications for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'clasifications', 'delete');
end$$


create trigger insert_aud_products
after insert on products for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'products', 'insert');
end$$

create trigger update_aud_products
before update on products for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'products', 'update');
end$$

create trigger delete_aud_products
after delete on products for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'products', 'delete');
end$$


create trigger insert_aud_games
after insert on games for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'games', 'insert');
end$$

create trigger update_aud_games
before update on games for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'games', 'update');
end$$

create trigger delete_aud_games
after delete on games for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'games', 'delete');
end$$


create trigger insert_aud_consoles
after insert on consoles for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'consoles', 'insert');
end$$

create trigger update_aud_consoles
before update on consoles for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'consoles', 'update');
end$$

create trigger delete_aud_consoles
after delete on consoles for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'consoles', 'delete');
end$$


create trigger insert_aud_sales_order
after insert on sales_order for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'sales_order', 'insert');
end$$

create trigger update_aud_sales_order
before update on sales_order for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'sales_order', 'update');
end$$

create trigger delete_aud_sales_order
after delete on sales_order for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'sales_order', 'delete');
end$$


create trigger insert_aud_order_details
after insert on order_details for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'order_details', 'insert');
end$$

create trigger update_aud_order_details
before update on order_details for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'order_details', 'update');
end$$

create trigger delete_aud_order_details
after delete on order_details for each row
begin
    insert into audit_log (log_date, log_user, log_table, operation)
    values (now(), user(), 'order_details', 'delete');
end$$

delimiter ;


-- -----------Stored Procedures------------
delimiter $$

create procedure sp_insert_client(
    in p_name varchar(255),
    in p_address varchar(255),
    in p_phone varchar(255),
    in p_birthday date
)
begin
    insert into clients(name_, address, phone, birthday)
    values (p_name, p_address, p_phone, p_birthday);
end$$
create procedure sp_insert_supplier(
    in p_name varchar(255),
    in p_address varchar(255),
    in p_phone varchar(255),
    in p_email varchar(255)
)
begin
    insert into suppliers(name_, address, phone, email)
    values (p_name, p_address, p_phone, p_email);
end$$

create procedure sp_insert_branch(
    in p_name varchar(255),
    in p_address varchar(255),
    in p_phone varchar(255),
    in p_email varchar(255)
)
begin
    insert into branches(name_, address, phone, email)
    values (p_name, p_address, p_phone, p_email);
end$$
--  pendientes  -- 

-- departments
create procedure sp_insert_department(
    in p_des varchar(255),
    in p_branch_id int
)
begin
    insert into departments(des, branch_id)
    values (p_des, p_branch_id);
end$$

-- roles
-- employees
-- consoles
-- clasifications 
-- games 
-- products
-- inventory
-- paymethods
-- sales_order
-- order_details


