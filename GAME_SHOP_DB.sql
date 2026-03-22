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

--  client
#insert
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

#read
create procedure sp_get_clients()
begin
    select * from clients;
end$$

#update
create procedure sp_update_client(
    in p_id int,
    in p_name varchar(255),
    in p_address varchar(255),
    in p_phone varchar(255),
    in p_birthday date
)
begin
    update clients
    set name_ = p_name,
        address = p_address,
        phone = p_phone,
        birthday = p_birthday
    where client_id = p_id;
end$$

#delete
create procedure sp_delete_client(
    in p_id int
)
begin
    delete from clients
    where client_id = p_id;
end$$

-- supplier
#create
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

#read
create procedure sp_get_suppliers()
begin
    select * from suppliers;
end$$

#update
create procedure sp_update_supplier(
    in p_id int,
    in p_name varchar(255),
    in p_address varchar(255),
    in p_phone varchar(255),
    in p_email varchar(255)
)
begin
    update suppliers
    set name_ = p_name,
        address = p_address,
        phone = p_phone,
        email = p_email
    where supplier_id = p_id;
end$$

#delete
create procedure sp_delete_supplier(
    in p_id int
)
begin
    delete from suppliers
    where supplier_id = p_id;
end$$

-- branch
#insert
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

#read
create procedure sp_get_branches()
begin
    select * from branches;
end$$

#update
create procedure sp_update_branch(
    in p_id int,
    in p_name varchar(255),
    in p_address varchar(255),
    in p_phone varchar(255),
    in p_email varchar(255)
)
begin
    update branches
    set name_ = p_name,
        address = p_address,
        phone = p_phone,
        email = p_email
    where branch_id = p_id;
end$$

#delete
create procedure sp_delete_branch(
    in p_id int
)
begin
    delete from branches
    where branch_id = p_id;
end$$

-- departments
#insert
create procedure sp_insert_department(
    in p_des varchar(255),
    in p_branch_id int
)
begin
    insert into departments(des, branch_id)
    values (p_des, p_branch_id);
end$$

#read
create procedure sp_get_departments()
begin
    select * from departments;
end$$

#update
create procedure sp_update_department(
    in p_id int,
    in p_des varchar(255),
    in p_branch_id int
)
begin
    update departments
    set des = p_des,
        branch_id = p_branch_id
    where department_id = p_id;
end$$

#delete
create procedure sp_delete_department(
    in p_id int
)
begin
    delete from departments
    where department_id = p_id;
end$$

-- roles
#insert
create procedure sp_insert_role(
    in p_name enum('manager','cashier','inventory_clerk','support')
)
begin
    insert into roles(name_)
    values (p_name);
end$$

#read
create procedure sp_get_roles()
begin
    select * from roles;
end$$

#update
create procedure sp_update_role(
    in p_id int,
    in p_name enum('manager','cashier','inventory_clerk','support')
)
begin
    update roles
    set name_ = p_name
    where role_id = p_id;
end$$

#delete
create procedure sp_delete_role(
    in p_id int
)
begin
    delete from roles
    where role_id = p_id;
end$$

-- employees
#insert
create procedure sp_insert_employee(
    in p_name varchar(255),
    in p_address varchar(255),
    in p_phone varchar(255),
    in p_email varchar(255),
    in p_department_id int,
    in p_role_id int,
    in p_birthday date,
    in p_contract_day date
)
begin
    insert into employees(name_, address, phone, email, department_id, role_id, birthday, contract_day)
    values (p_name, p_address, p_phone, p_email, p_department_id, p_role_id, p_birthday, p_contract_day);
end$$
#read
create procedure sp_get_employees()
begin
    select * from employees;
end$$

#update
create procedure sp_update_employee(
    in p_id int,
    in p_name varchar(255),
    in p_address varchar(255),
    in p_phone varchar(255),
    in p_email varchar(255),
    in p_department_id int,
    in p_role_id int,
    in p_birthday date,
    in p_contract_day date
)
begin
    update employees
    set name_ = p_name,
        address = p_address,
        phone = p_phone,
        email = p_email,
        department_id = p_department_id,
        role_id = p_role_id,
        birthday = p_birthday,
        contract_day = p_contract_day
    where employee_id = p_id;
end$$

#delete
create procedure sp_delete_employee(
    in p_id int
)
begin
    delete from employees
    where employee_id = p_id;
end$$

-- consoles
#insert
create procedure sp_insert_console(
    in p_name varchar(255)
)
begin
    insert into consoles(name_)
    values (p_name);
end$$

#read
create procedure sp_get_consoles()
begin
    select * from consoles;
end$$

#update
create procedure sp_update_console(
    in p_id int,
    in p_name varchar(255)
)
begin
    update consoles
    set name_ = p_name
    where console_id = p_id;
end$$

#delete
create procedure sp_delete_console(
    in p_id int
)
begin
    delete from consoles
    where console_id = p_id;
end$$

-- clasifications 
#insert
create procedure sp_insert_clasification(
    in p_des enum('EC','E','E10+','T','M','AO','RP')
)
begin
    insert into clasifications(des)
    values (p_des);
end$$

#read
create procedure sp_get_clasifications()
begin
    select * from clasifications;
end$$

#update
create procedure sp_update_clasification(
    in p_id int,
    in p_des enum('EC','E','E10+','T','M','AO','RP')
)
begin
    update clasifications
    set des = p_des
    where clasification_id = p_id;
end$$

#delete
create procedure sp_delete_clasification(
    in p_id int
)
begin
    delete from clasifications
    where clasification_id = p_id;
end$$

-- games 
#insert
create procedure sp_insert_game(
    in p_name varchar(255),
    in p_des varchar(255),
    in p_developer varchar(255),
    in p_clasification_id int,
    in p_console_id int
)
begin
    insert into games(name_, des, developer, clasification_id, console_id)
    values (p_name, p_des, p_developer, p_clasification_id, p_console_id);
end$$

#read
create procedure sp_get_games()
begin
    select * from games;
end$$
 
#update
create procedure sp_update_game(
    in p_id int,
    in p_name varchar(255),
    in p_des varchar(255),
    in p_developer varchar(255),
    in p_clasification_id int,
    in p_console_id int
)
begin
    update games
    set name_ = p_name,
        des = p_des,
        developer = p_developer,
        clasification_id = p_clasification_id,
        console_id = p_console_id
    where game_id = p_id;
end$$
 
#delete
create procedure sp_delete_game(
    in p_id int
)
begin
    delete from games
    where game_id = p_id;
end$$
 
-- products
#insert
create procedure sp_insert_product(
    in p_type enum('game','console','accessory'),
    in p_name varchar(255),
    in p_des varchar(255),
    in p_price float,
    in p_console_id int,
    in p_game_id int
)
begin
    insert into products(product_type, name_, des, price, console_id, game_id)
    values (p_type, p_name, p_des, p_price, p_console_id, p_game_id);
end$$

#read
create procedure sp_get_products()
begin
    select * from products;
end$$

#update
create procedure sp_update_product(
    in p_id int,
    in p_price float
)
begin
    update products
    set price = p_price
    where product_id = p_id;
end$$

#delete
create procedure sp_delete_product(
    in p_id int
)
begin
    delete from products
    where product_id = p_id;
end$$

-- inventory
#insert
create procedure sp_insert_inventory(
    in p_product_id int,
    in p_stock int,
    in p_supplier_id int,
    in p_branch_id int
)
begin
    insert into inventory(product_id, stock, supplier_id, branch_id)
    values (p_product_id, p_stock, p_supplier_id, p_branch_id);
end$$
 
#read
create procedure sp_get_inventory()
begin
    select * from inventory;
end$$
 
#update
create procedure sp_update_inventory(
    in p_id int,
    in p_product_id int,
    in p_stock int,
    in p_supplier_id int,
    in p_branch_id int
)
begin
    update inventory
    set product_id = p_product_id,
        stock = p_stock,
        supplier_id = p_supplier_id,
        branch_id = p_branch_id
    where inventory_id = p_id;
end$$
 
#delete
create procedure sp_delete_inventory(
    in p_id int
)
begin
    delete from inventory
    where inventory_id = p_id;
end$$

-- paymethods
#insert
create procedure sp_insert_paymethod(
    in p_des enum('cash','credit_card','debit_card','transfer')
)
begin
    insert into paymethods(des)
    values (p_des);
end$$
 
#read
create procedure sp_get_paymethods()
begin
    select * from paymethods;
end$$
 
#update
create procedure sp_update_paymethod(
    in p_id int,
    in p_des enum('cash','credit_card','debit_card','transfer')
)
begin
    update paymethods
    set des = p_des
    where paymethod_id = p_id;
end$$
 
#delete
create procedure sp_delete_paymethod(
    in p_id int
)
begin
    delete from paymethods
    where paymethod_id = p_id;
end$$

-- sales_order
#insert
create procedure sp_insert_sales_order(
    in p_employee_id int,
    in p_client_id int,
    in p_paymethod_id int,
    in p_date date,
    in p_total float
)
begin
    insert into sales_order(employee_id, client_id, paymethod_id, date_, total)
    values (p_employee_id, p_client_id, p_paymethod_id, p_date, p_total);
end$$
 
#read
create procedure sp_get_sales_orders()
begin
    select * from sales_order;
end$$
 
#update
create procedure sp_update_sales_order(
    in p_id int,
    in p_employee_id int,
    in p_client_id int,
    in p_paymethod_id int,
    in p_date date,
    in p_total float
)
begin
    update sales_order
    set employee_id = p_employee_id,
        client_id = p_client_id,
        paymethod_id = p_paymethod_id,
        date_ = p_date,
        total = p_total
    where sale_id = p_id;
end$$
 
#delete
create procedure sp_delete_sales_order(
    in p_id int
)
begin
    delete from sales_order
    where sale_id = p_id;
end$$

-- order_details
#insert
create procedure sp_insert_order_detail(
    in p_sale_id int,
    in p_product_id int,
    in p_quantity int,
    in p_unit_price float
)
begin
    insert into order_details(sale_id, product_id, quantity, unit_price)
    values (p_sale_id, p_product_id, p_quantity, p_unit_price);
end$$
 
#read
create procedure sp_get_order_details()
begin
    select * from order_details;
end$$
 
#update
create procedure sp_update_order_detail(
    in p_id int,
    in p_sale_id int,
    in p_product_id int,
    in p_quantity int,
    in p_unit_price float
)
begin
    update order_details
    set sale_id = p_sale_id,
        product_id = p_product_id,
        quantity = p_quantity,
        unit_price = p_unit_price
    where order_detail_id = p_id;
end$$
 
#delete
create procedure sp_delete_order_detail(
    in p_id int
)
begin
    delete from order_details
    where order_detail_id = p_id;
end$$

delimiter ;

-- -----------------Inserts-------------------






