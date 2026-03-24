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
-- 1. CLASSIFICATIONS 
INSERT INTO clasifications (des) VALUES
('EC'),
('E'),
('E10+'),
('T'),
('M'),
('AO'),
('RP');

-- 2. CONSOLES 
INSERT INTO consoles (name_) VALUES
('PlayStation 4'),
('PlayStation 5'),
('Xbox One'),
('Xbox Series X'),
('Nintendo Switch'),
('Nintendo Switch Lite'),
('PC'),
('Steam Deck'),
('PlayStation 3'),
('Nintendo 3DS');

-- 3. BRANCHES
INSERT INTO branches (name_, address, phone, email) VALUES
('GameShop Tijuana',     'Blvd. Agua Caliente 1200, Tijuana, BC',    '664-100-1001', 'tijuana@gameshop.mx'),
('GameShop Guadalajara', 'Av. Patria 500, Zapopan, Jalisco',         '333-100-2002', 'guadalajara@gameshop.mx'),
('GameShop CDMX Norte',  'Av. Insurgentes Norte 1800, CDMX',         '555-100-3003', 'cdmxnorte@gameshop.mx'),
('GameShop CDMX Sur',    'Av. Insurgentes Sur 2453, CDMX',           '555-100-4004', 'cdmxsur@gameshop.mx'),
('GameShop Monterrey',   'Av. Garza Sada 2501, Monterrey, NL',       '818-100-5005', 'monterrey@gameshop.mx'),
('GameShop Puebla',      'Blvd. Atlixcáyotl 2900, Puebla',           '222-100-6006', 'puebla@gameshop.mx'),
('GameShop Mérida',      'Calle 60 Norte 299, Mérida, Yucatán',      '999-100-7007', 'merida@gameshop.mx'),
('GameShop Querétaro',   'Av. Constituyentes 100, Querétaro',        '442-100-8008', 'queretaro@gameshop.mx'),
('GameShop León',        'Blvd. López Mateos 2002, León, Guanajuato','477-100-9009', 'leon@gameshop.mx'),
('GameShop Hermosillo',  'Blvd. Kino 800, Hermosillo, Sonora',       '662-100-1010', 'hermosillo@gameshop.mx');

-- 4. DEPARTMENTS
INSERT INTO departments (des, branch_id) VALUES
('Ventas', 1), ('Almacén', 1),
('Ventas', 2), ('Almacén', 2),
('Ventas', 3), ('Almacén', 3),
('Ventas', 4), ('Almacén', 4),
('Ventas', 5), ('Almacén', 5),
('Ventas', 6), ('Almacén', 6),
('Ventas', 7), ('Almacén', 7),
('Ventas', 8), ('Almacén', 8),
('Ventas', 9), ('Almacén', 9),
('Ventas',10), ('Almacén',10);

-- 5. ROLES 
INSERT INTO roles (name_) VALUES
('manager'),
('cashier'),
('inventory_clerk'),
('support');

-- 6. SUPPLIERS 
INSERT INTO suppliers (name_, address, phone, email) VALUES
('Sony Interactive Entertainment MX', 'Av. Santa Fe 440, CDMX',            '555-200-1001', 'ventas@sony.com.mx'),
('Microsoft México',                  'Paseo de la Reforma 300, CDMX',      '555-200-2002', 'ventas@microsoft.com.mx'),
('Nintendo de México',                'Insurgentes Sur 800, CDMX',          '555-200-3003', 'ventas@nintendo.com.mx'),
('Distribuidora GameWorld',           'Blvd. Manuel Ávila Camacho 40, CDMX','555-200-4004', 'contacto@gameworld.mx'),
('TechGames Distribuciones',          'Av. Revolucion 1200, Guadalajara',   '333-200-5005', 'info@techgames.mx');

-- 7. PAYMENT METHODS 
INSERT INTO paymethods (des) VALUES
('cash'),
('credit_card'),
('debit_card'),
('transfer');

-- 8. GAMES
INSERT INTO games (name_, des, developer, clasification_id, console_id) VALUES
('The Last of Us Part II',    'Aventura post-apocalíptica de supervivencia y acción', 'Naughty Dog',        5, 1),
('God of War Ragnarök',       'Acción épica mitológica nórdica con Kratos y Atreus',  'Santa Monica Studio',5, 2),
('Halo Infinite',             'Shooter en primera persona, regreso del Jefe Maestro', '343 Industries',     4, 4),
('The Legend of Zelda: TOTK', 'Aventura de mundo abierto en el reino de Hyrule',      'Nintendo EPD',       3, 5),
('FIFA 24',                   'Simulador de fútbol con licencias oficiales',           'EA Sports',          3, 2),
('Elden Ring',                'RPG de acción en mundo abierto oscuro y desafiante',   'FromSoftware',       5, 2),
('Mario Kart 8 Deluxe',       'Carreras de karts con personajes del universo Mario',  'Nintendo EPD',       2, 5),
('Red Dead Redemption 2',     'Western de mundo abierto en el salvaje oeste americano','Rockstar Games',    5, 1),
('Minecraft',                 'Juego de construcción y supervivencia en mundo sandbox','Mojang Studios',    2, 5),
('Forza Horizon 5',           'Simulador de carreras en mundo abierto ambientado en México','Playground Games',3,4);

-- 9. PRODUCTS 
INSERT INTO products (product_type, name_, des, price, console_id, game_id) VALUES
('game',      'The Last of Us Part II',   'Edición estándar PS4',              899.00,  1,    1),
('game',      'God of War Ragnarök',      'Edición estándar PS5',             1199.00,  2,    2),
('game',      'Halo Infinite',            'Edición estándar Xbox Series X',    999.00,  4,    3),
('game',      'Zelda: Tears of the Kingdom','Edición estándar Switch',        1199.00,  5,    4),
('game',      'FIFA 24',                  'Edición estándar PS5',              899.00,  2,    5),
('game',      'Elden Ring',               'Edición estándar PS5',             1099.00,  2,    6),
('game',      'Mario Kart 8 Deluxe',      'Edición estándar Switch',           899.00,  5,    7),
('game',      'Red Dead Redemption 2',    'Edición estándar PS4',              799.00,  1,    8),
('game',      'Minecraft',                'Edición física Switch',             699.00,  5,    9),
('game',      'Forza Horizon 5',          'Edición estándar Xbox Series X',    999.00,  4,   10),
('console',   'PlayStation 5',            'Consola Sony PS5 825GB',          12999.00,  2, NULL),
('console',   'PlayStation 4 Slim',       'Consola Sony PS4 1TB',             5999.00,  1, NULL),
('console',   'Xbox Series X',            'Consola Microsoft 1TB',           12999.00,  4, NULL),
('console',   'Nintendo Switch OLED',     'Consola Nintendo pantalla OLED',   8999.00,  5, NULL),
('console',   'Nintendo Switch Lite',     'Consola portátil Nintendo',        5499.00,  6, NULL),
('accessory', 'Control DualSense PS5',    'Control inalámbrico blanco PS5',   1299.00,  2, NULL),
('accessory', 'Control Xbox Series',      'Control inalámbrico negro Xbox',    999.00,  4, NULL),
('accessory', 'Audífonos Pulse 3D PS5',   'Audífonos inalámbricos Sony',      1599.00,  2, NULL),
('accessory', 'Tarjeta SSD PS5 1TB',      'Expansión de almacenamiento PS5',  2499.00,  2, NULL),
('accessory', 'Joy-Con Nintendo Switch',  'Par de Joy-Con neón rojo/azul',     999.00,  5, NULL);

-- 10. INVENTORY
INSERT INTO inventory (product_id, stock, supplier_id, branch_id) VALUES
(1,  15, 4,  1), (2,  10, 1,  1), (11,  5, 1,  1), (16,  8, 1,  1),
(3,  12, 4,  2), (4,  20, 3,  2), (13,  4, 2,  2), (17,  6, 2,  2),
(5,  18, 1,  3), (6,  14, 1,  3), (12,  7, 1,  3), (18,  5, 1,  3),
(7,  25, 3,  4), (8,  10, 4,  4), (14,  6, 3,  4), (19, 10, 1,  4),
(9,  30, 3,  5), (10, 12, 2,  5), (15,  8, 3,  5), (20, 15, 3,  5),
(1,  10, 4,  6), (4,  15, 3,  6), (11,  3, 1,  6), (16,  4, 1,  6),
(2,   8, 1,  7), (7,  20, 3,  7), (13,  2, 2,  7), (17,  3, 2,  7),
(3,  10, 2,  8), (9,  25, 3,  8), (14,  4, 3,  8), (18,  4, 1,  8),
(5,  12, 1,  9), (6,   8, 1,  9), (15,  5, 3,  9), (20,  8, 3,  9),
(8,  14, 4, 10), (10, 10, 2, 10), (12,  3, 1, 10), (19,  6, 1, 10);

-- 11. EMPLOYEES 
INSERT INTO employees (name_, address, phone, email, department_id, role_id, birthday, contract_day) VALUES
('Carlos Mendoza Ruiz',     'Calle Roble 12, Tijuana',          '664-301-0001', 'cmendoza@gameshop.mx',    1, 1, '1985-03-15', '2018-01-10'),
('Laura Sánchez Torres',    'Av. Revolución 45, Tijuana',       '664-301-0002', 'lsanchez@gameshop.mx',    2, 3, '1995-07-22', '2020-06-01'),
('Diego Flores García',     'Calle Pino 8, Guadalajara',        '333-301-0003', 'dflores@gameshop.mx',     3, 1, '1983-11-05', '2017-03-15'),
('Ana Martínez López',      'Av. Patria 200, Guadalajara',      '333-301-0004', 'amartinez@gameshop.mx',   4, 3, '1997-01-30', '2021-02-10'),
('Roberto Jiménez Vega',    'Calz. Vallejo 500, CDMX',          '555-301-0005', 'rjimenez@gameshop.mx',    5, 1, '1980-09-18', '2016-07-20'),
('María González Pérez',    'Av. Cuitláhuac 300, CDMX',         '555-301-0006', 'mgonzalez@gameshop.mx',   6, 2, '1999-04-12', '2022-01-15'),
('Fernando Ramírez Cruz',   'Col. Del Valle 100, CDMX',         '555-301-0007', 'framirez@gameshop.mx',    7, 1, '1982-06-25', '2015-09-01'),
('Sofía Torres Morales',    'Av. Universidad 800, CDMX',        '555-301-0008', 'storres@gameshop.mx',     8, 2, '1996-12-03', '2020-11-20'),
('Héctor Reyes Castillo',   'Av. Garza Sada 1200, Monterrey',   '818-301-0009', 'hreyes@gameshop.mx',      9, 1, '1979-08-14', '2014-04-05'),
('Valeria Herrera Núñez',   'Calle Hidalgo 34, Monterrey',      '818-301-0010', 'vherrera@gameshop.mx',   10, 3, '1998-02-28', '2021-08-15'),
('Luis Moreno Díaz',        'Blvd. Atlixco 400, Puebla',        '222-301-0011', 'lmoreno@gameshop.mx',    11, 1, '1987-05-20', '2019-03-10'),
('Daniela Vargas Romo',     'Av. Juárez 56, Puebla',            '222-301-0012', 'dvargas@gameshop.mx',    12, 2, '1994-10-07', '2020-07-01'),
('Jorge Gutiérrez Silva',   'Calle 58 #300, Mérida',            '999-301-0013', 'jgutierrez@gameshop.mx', 13, 1, '1981-07-11', '2016-11-15'),
('Patricia Luna Espinoza',  'Calle 42 #120, Mérida',            '999-301-0014', 'pluna@gameshop.mx',      14, 4, '1993-03-25', '2019-09-01'),
('Andrés Peña Montes',      'Av. Constituyentes 450, Qro',      '442-301-0015', 'apena@gameshop.mx',      15, 1, '1984-12-01', '2017-06-20'),
('Carmen Ríos Blanco',      'Calle Zaragoza 88, Querétaro',     '442-301-0016', 'crios@gameshop.mx',      16, 2, '1997-06-18', '2021-04-10'),
('Eduardo Soto Paredes',    'Blvd. López Mateos 900, León',     '477-301-0017', 'esoto@gameshop.mx',      17, 1, '1986-09-30', '2018-08-01'),
('Gabriela Castro Fuentes', 'Av. Torres Landa 200, León',       '477-301-0018', 'gcastro@gameshop.mx',    18, 3, '1995-11-14', '2020-02-15'),
('Ricardo Ortega Campos',   'Blvd. Kino 400, Hermosillo',       '662-301-0019', 'rortega@gameshop.mx',    19, 1, '1978-04-06', '2013-10-01'),
('Isabel Medina Aguilar',   'Calle Sonora 77, Hermosillo',      '662-301-0020', 'imedina@gameshop.mx',    20, 2, '1992-08-19', '2019-05-20');

-- 12. CLIENTS 
INSERT INTO clients (name_, address, phone, birthday) VALUES
('Alejandro García López',   'Calle 5 de Mayo 101, Tijuana',        '664-401-0001', '1990-03-12'),
('Brenda Morales Soto',      'Av. Revolución 202, Tijuana',         '664-401-0002', '1995-07-25'),
('Carlos Vega Ríos',         'Blvd. Agua Caliente 303, Tijuana',    '664-401-0003', '1988-11-08'),
('Diana Torres Cruz',        'Calle Madero 404, Tijuana',           '664-401-0004', '2000-01-30'),
('Eduardo Jiménez Ruiz',     'Av. Tecnológico 505, Tijuana',        '664-401-0005', '1993-05-17'),
('Fernanda Reyes Castillo',  'Calle Juárez 606, Guadalajara',       '333-401-0006', '1997-09-03'),
('Gabriel Hernández Pérez',  'Av. Patria 707, Guadalajara',         '333-401-0007', '1985-12-22'),
('Heidi Martínez Flores',    'Col. Providencia 808, Guadalajara',   '333-401-0008', '1992-04-14'),
('Iván Sánchez Vargas',      'Av. Vallarta 909, Guadalajara',       '333-401-0009', '1999-08-06'),
('Jessica López Mendoza',    'Calle Niños Héroes 100, Guadalajara', '333-401-0010', '2001-02-19'),
('Kevin Ramírez Núñez',      'Av. Insurgentes 1001, CDMX',          '555-401-0011', '1994-06-28'),
('Liliana Gutiérrez Luna',   'Col. Narvarte 102, CDMX',             '555-401-0012', '1989-10-15'),
('Marcos Herrera Díaz',      'Av. División del Norte 203, CDMX',   '555-401-0013', '1996-03-07'),
('Natalia Ortega Blanco',    'Calle Mesones 304, CDMX',             '555-401-0014', '1991-07-20'),
('Óscar Moreno Aguilar',     'Col. Roma 405, CDMX',                 '555-401-0015', '1987-11-11'),
('Paola Castro Fuentes',     'Av. Coyoacán 506, CDMX',              '555-401-0016', '1998-01-04'),
('Quirino Peña Torres',      'Col. Del Valle 607, CDMX',            '555-401-0017', '2002-05-29'),
('Rosa Vega Espinoza',       'Av. Xochimilco 708, CDMX',            '555-401-0018', '1986-09-16'),
('Samuel Flores Montes',     'Calle Michoacán 809, CDMX',           '555-401-0019', '1993-02-08'),
('Tania Soto Campos',        'Av. Nuevo León 910, CDMX',            '555-401-0020', '1990-06-23'),
('Ulises Díaz Romo',         'Av. Garza Sada 1011, Monterrey',      '818-401-0021', '1984-10-05'),
('Valeria Luna Paredes',     'Calle Hidalgo 1112, Monterrey',       '818-401-0022', '1997-04-18'),
('William Medina García',    'Blvd. Morones Prieto 1213, Monterrey','818-401-0023', '1991-08-30'),
('Ximena Torres López',      'Col. Mitras 1314, Monterrey',         '818-401-0024', '2003-01-12'),
('Yael Jiménez Reyes',       'Av. Ruiz Cortines 1415, Monterrey',   '818-401-0025', '1988-05-25'),
('Zoe Hernández Cruz',       'Calle San Francisco 1516, Monterrey', '818-401-0026', '1995-09-07'),
('Adrián García Soto',       'Blvd. Atlixco 1617, Puebla',          '222-401-0027', '1992-12-20'),
('Beatriz Vargas Ríos',      'Av. Juárez 1718, Puebla',             '222-401-0028', '1987-03-02'),
('César Morales Castillo',   'Calle Reforma 1819, Puebla',          '222-401-0029', '1999-07-15'),
('Daniela Pérez Mendoza',    'Col. Huexotitla 1920, Puebla',        '222-401-0030', '1994-11-28'),
('Emilio Reyes Flores',      'Av. CAPU 2021, Puebla',               '222-401-0031', '1982-04-10'),
('Fabiola Martínez Núñez',   'Blvd. Forjadores 2122, Puebla',       '222-401-0032', '1996-08-23'),
('Gerardo Sánchez Díaz',     'Calle 60 Norte 2223, Mérida',         '999-401-0033', '1989-01-05'),
('Helena López Blanco',      'Av. Itzáes 2324, Mérida',             '999-401-0034', '2001-05-18'),
('Ignacio Castro Aguilar',   'Calle 47 #2425, Mérida',              '999-401-0035', '1986-09-30'),
('Jasmin Torres Fuentes',    'Col. Buenavista 2526, Mérida',        '999-401-0036', '1993-02-12'),
('Karl Gutiérrez Espinoza',  'Av. Periférico 2627, Mérida',         '999-401-0037', '1998-06-25'),
('Laura Ortega Montes',      'Calle Cupules 2728, Mérida',          '999-401-0038', '1991-10-08'),
('Miguel Herrera Campos',    'Av. Constituyentes 2829, Querétaro',  '442-401-0039', '1984-03-20'),
('Nancy Moreno Romo',        'Calle Corregidora 2930, Querétaro',   '442-401-0040', '1997-07-03'),
('Orlando Vega Paredes',     'Blvd. Bernardo Quintana 3031, Querétaro','442-401-0041','1990-11-15'),
('Patricia Díaz García',     'Col. Juriquilla 3132, Querétaro',     '442-401-0042', '2002-04-28'),
('Quintín Reyes López',      'Av. 5 de Febrero 3233, Querétaro',    '442-401-0043', '1987-08-10'),
('Renata Soto Torres',       'Calle Pino Suárez 3334, Querétaro',   '442-401-0044', '1994-12-23'),
('Sergio Flores Reyes',      'Blvd. López Mateos 3435, León',       '477-401-0045', '1981-05-05'),
('Tamara Jiménez Cruz',      'Av. Torres Landa 3536, León',         '477-401-0046', '1996-09-18'),
('Uriel Hernández Vargas',   'Calle San Juan Bosco 3637, León',     '477-401-0047', '1989-01-30'),
('Valeria Martínez Soto',    'Col. Arboledas 3738, León',           '477-401-0048', '2000-06-13'),
('Walter Gutiérrez Ríos',    'Av. Insurgentes 3839, León',          '477-401-0049', '1993-10-26'),
('Ximena Ortega Castillo',   'Calle León 1 Sur 3940, León',         '477-401-0050', '1988-03-08'),
('Yahir Castro Mendoza',     'Blvd. Kino 4041, Hermosillo',         '662-401-0051', '1995-07-21'),
('Zara Morales Díaz',        'Av. Rosales 4142, Hermosillo',        '662-401-0052', '1991-11-03'),
('Alberto Peña Luna',        'Calle Sonora 4243, Hermosillo',       '662-401-0053', '2003-04-16'),
('Bianca Reyes Aguilar',     'Col. Pitic 4344, Hermosillo',         '662-401-0054', '1986-08-29'),
('Camilo Torres Blanco',     'Av. Luis Donaldo Colosio 4445, Hermosillo','662-401-0055','1999-01-11'),
('Débora Sánchez Fuentes',   'Calle Matamoros 4546, Hermosillo',    '662-401-0056', '1994-05-24'),
('Ernesto García Espinoza',  'Av. Revolución 4647, Tijuana',        '664-401-0057', '1982-09-06'),
('Flor Vega Montes',         'Blvd. Cuauhtémoc 4748, Tijuana',      '664-401-0058', '1997-02-19'),
('Gonzalo Jiménez Campos',   'Calle Altamirano 4849, Tijuana',      '664-401-0059', '1990-06-02'),
('Hilda Hernández Romo',     'Av. Internacional 4950, Tijuana',     '664-401-0060', '2001-10-15'),
('Isaías López Paredes',     'Calle Obregón 5051, Guadalajara',     '333-401-0061', '1985-03-27'),
('Johanna Martínez García',  'Av. Chapultepec 5152, Guadalajara',   '333-401-0062', '1998-07-10'),
('Kevin Morales Torres',     'Col. Americana 5253, Guadalajara',    '333-401-0063', '1992-11-22'),
('Lorena Reyes Reyes',       'Av. Federalismo 5354, Guadalajara',   '333-401-0064', '1987-04-05'),
('Manuel Soto Cruz',         'Calle Hidalgo 5455, Guadalajara',     '333-401-0065', '2000-08-18'),
('Norma Gutiérrez Vargas',   'Blvd. Tlaquepaque 5556, Guadalajara', '333-401-0066', '1995-01-30'),
('Octavio Ortega Soto',      'Av. Insurgentes Sur 5657, CDMX',      '555-401-0067', '1983-06-13'),
('Pamela Castro López',      'Col. Condesa 5758, CDMX',             '555-401-0068', '1996-10-26'),
('Rafael Moreno Torres',     'Calle Durango 5859, CDMX',            '555-401-0069', '1989-03-08'),
('Sandra Vega Reyes',        'Av. Sonora 5960, CDMX',               '555-401-0070', '2002-07-21'),
('Tomás Díaz Flores',        'Col. Santa María 6061, CDMX',         '555-401-0071', '1986-11-03'),
('Ursula Reyes Mendoza',     'Av. Michoacán 6162, CDMX',            '555-401-0072', '1993-04-16'),
('Víctor García Castillo',   'Calle Veracruz 6263, CDMX',           '555-401-0073', '1980-08-29'),
('Wendy Torres Díaz',        'Blvd. Adolfo López Mateos 6364, CDMX','555-401-0074', '1997-01-11'),
('Xerxes Jiménez Aguilar',   'Av. Coyoacán 6465, CDMX',             '555-401-0075', '1991-05-24'),
('Yolanda Hernández Blanco', 'Col. Del Carmen 6566, CDMX',          '555-401-0076', '1984-09-06'),
('Zacarías Sánchez Fuentes', 'Av. Universidad 6667, CDMX',          '555-401-0077', '1999-02-19'),
('Aurora Morales Espinoza',  'Av. Garza Sada 6768, Monterrey',      '818-401-0078', '1994-06-02'),
('Bruno Ortega Montes',      'Calle Ocampo 6869, Monterrey',        '818-401-0079', '1988-10-15'),
('Claudia Reyes Campos',     'Blvd. Constitución 6970, Monterrey',  '818-401-0080', '2001-03-27'),
('Dante Vega Romo',          'Col. San Nicolás 7071, Monterrey',    '818-401-0081', '1985-07-10'),
('Elena Flores Paredes',     'Av. Colón 7172, Monterrey',           '818-401-0082', '1998-11-22'),
('Felipe Castro García',     'Calle Monterrey 7273, Puebla',        '222-401-0083', '1992-04-05'),
('Gloria Moreno Torres',     'Av. Reforma 7374, Puebla',            '222-401-0084', '1987-08-18'),
('Hugo Jiménez Cruz',        'Col. La Paz 7475, Puebla',            '222-401-0085', '2000-01-30'),
('Irene Hernández Vargas',   'Blvd. Norte 7576, Puebla',            '222-401-0086', '1995-05-13'),
('Julio Martínez Soto',      'Calle 2 Sur 7677, Puebla',            '222-401-0087', '1982-09-26'),
('Karen López Reyes',        'Av. Tecnológico 7778, Puebla',        '222-401-0088', '1996-02-08'),
('Leonardo Gutiérrez Ríos',  'Calle 58 #7879, Mérida',              '999-401-0089', '1989-06-21'),
('Mónica Ortega Castillo',   'Av. Itzáes 7980, Mérida',             '999-401-0090', '2002-10-03'),
('Néstor Soto Mendoza',      'Col. García Ginerés 8081, Mérida',    '999-401-0091', '1986-03-16'),
('Olga Reyes Díaz',          'Calle 25 #8182, Mérida',              '999-401-0092', '1993-07-29'),
('Pablo García Luna',        'Av. Reforma 8283, Querétaro',         '442-401-0093', '1980-12-11'),
('Quiteria Torres Aguilar',  'Blvd. Villas del Mesón 8384, Querétaro','442-401-0094','1997-04-24'),
('Rodrigo Vega Blanco',      'Calle Allende 8485, Querétaro',       '442-401-0095', '1990-08-06'),
('Silvia Flores Fuentes',    'Col. Centro 8586, León',              '477-401-0096', '2003-01-19'),
('Tadeo Jiménez Espinoza',   'Av. Hidalgo 8687, León',              '477-401-0097', '1987-05-02'),
('Úrsula Hernández Montes',  'Blvd. Juan Alonso 8788, León',        '477-401-0098', '1994-09-15'),
('Vladimir Martínez Campos', 'Calle Pedro Moreno 8889, León',       '477-401-0099', '1981-02-27'),
('Wendy Sánchez Romo',       'Av. Tecnológico 8990, Hermosillo',    '662-401-0100', '1998-06-11');

-- 13. SALES ORDERS 
INSERT INTO sales_order (employee_id, client_id, paymethod_id, date_, total) VALUES
( 2,  1, 1, '2024-01-15',   899.00),
( 2,  5, 2, '2024-01-20',  1199.00),
( 4,  6, 3, '2024-02-03',   999.00),
( 4, 10, 2, '2024-02-14',  2098.00),
( 6, 11, 1, '2024-03-01',   899.00),
( 6, 15, 3, '2024-03-10',  1099.00),
( 8, 16, 2, '2024-03-25', 12999.00),
( 8, 20, 1, '2024-04-05',   799.00),
(10, 21, 3, '2024-04-18',   699.00),
(10, 25, 2, '2024-05-02',   999.00),
(12, 26, 1, '2024-05-15',   899.00),
(12, 30, 3, '2024-06-01',  8999.00),
(14, 31, 2, '2024-06-12',  1199.00),
(14, 35, 1, '2024-07-04',   899.00),
(16, 36, 3, '2024-07-20',  1599.00),
(16, 40, 2, '2024-08-08',  1299.00),
(18, 41, 1, '2024-08-22',   999.00),
(18, 45, 3, '2024-09-10',  3598.00),
(20, 46, 2, '2024-09-25',  1099.00),
(20, 50, 1, '2024-10-01',   699.00);

-- 14. ORDER DETAILS
INSERT INTO order_details (sale_id, product_id, quantity, unit_price) VALUES
( 1,  1, 1,  899.00),
( 2,  2, 1, 1199.00),
( 3,  3, 1,  999.00),
( 4,  4, 1, 1199.00),
( 4,  7, 1,  899.00),
( 5,  5, 1,  899.00),
( 6,  6, 1, 1099.00),
( 7, 11, 1,12999.00),
( 8,  8, 1,  799.00),
( 9,  9, 1,  699.00),
(10, 10, 1,  999.00),
(11,  7, 1,  899.00),
(12, 14, 1, 8999.00),
(13,  2, 1, 1199.00),
(14,  5, 1,  899.00),
(15, 18, 1, 1599.00),
(16, 16, 1, 1299.00),
(17,  3, 1,  999.00), 
(18,  6, 1, 1099.00),
(18, 19, 1, 2499.00),
(19,  6, 1, 1099.00),
(20,  9, 1,  699.00);

-- =====VIEWS================

create view  view_employee_best_sale as 
select
e.employee_id,
e.name_ as empleado,
sum(so.total) as total_sales
from employees e
join sales_order so on e.employee_id = so.employee_id
group by e.employee_id, e.name_
order by total_sales desc
limit 1;
select * from view_employee_best_sale;


create view view_top3_consoles as
select 
    c.name_ as consola,
    sum(od.quantity) as qty_of_sales
from consoles c
join products p on c.console_id = p.console_id
join order_details od on p.product_id = od.product_id
group by c.console_id, c.name_
order by qty_of_sales desc
limit 3;
select * from view_top3_consoles;


create view view_top5_games as
select 
    g.name_ as game,
    g.developer,
    sum(od.quantity) as qty_of_sales
from games g
join products p on g.game_id = p.game_id
join order_details od on p.product_id = od.product_id
group by g.game_id, g.name_, g.developer
order by qty_of_sales desc
limit 5;
select * from view_top5_games;

create view view_branch_best_sale as
select
    b.branch_id,
    b.name_ as branch,
    sum(so.total) as total_sales
from branches b
join departments d on b.branch_id = d.branch_id
join employees e on d.department_id = e.department_id
join sales_order so on e.employee_id = so.employee_id
group by b.branch_id, b.name_
order by total_sales desc
limit 1;

select * from view_branch_best_sale;

create view view_product_low_stock as
select
    p.product_id,
    p.name_ as product,
    p.product_type,
    b.name_ as branch,
    i.stock
from inventory i
join products p on i.product_id = p.product_id
join branches b on i.branch_id = b.branch_id
order by i.stock asc
limit 1;

select * from view_product_low_stock;


create view view_frequent_client_by_branch as
select
    b.branch_id,
    b.name_ as branch,
    c.client_id,
    c.name_ as client,
    count(so.sale_id) as total_purchases
from branches b
join departments d on b.branch_id = d.branch_id
join employees e on d.department_id = e.department_id
join sales_order so on e.employee_id = so.employee_id
join clients c on so.client_id = c.client_id
group by b.branch_id, b.name_, c.client_id, c.name_
order by b.branch_id, total_purchases desc;

select * from view_frequent_client_by_branch;

