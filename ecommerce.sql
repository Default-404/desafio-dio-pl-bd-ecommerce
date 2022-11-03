-- Create a simple SQL script for a basic E-commerce scenario
create database ecommerce;
use ecommerce;

-- Create clients table
create table clients(
	idClients int auto_increment primary key,
    fullName varchar(35) not null,
    CPF char(11) not null,
    address varchar(255),
    constraint unique_cpf_clients unique (CPF)
);

-- Create creditCard table
create table creditCard(
	idCreditCard int auto_increment primary key,
    cardNumber char(16) not null,
    expDate date not null,
    ownerName varchar(35) not null,
    constraint unique_cardNumber_creditCard unique (cardNumber)
);

-- Create product table
create table product(
	idProduct int auto_increment primary key,
    category varchar(45),
    price float,
    productDescription varchar(255)
);

-- Create supplier table
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(100),
    CNPJ char(15) not null,
    constraint unique_CNPJ_supplier unique (CNPJ)
);

-- Create stock table
create table stock(
	idStock int auto_increment primary key,
    address varchar(255) not null
);

-- Create productSeller table
create table productSeller(
	idProductSeller int auto_increment primary key,
    socialName varchar(100),
    CNPJ char(15) not null,
    address varchar(255) not null,
    constraint unique_CNPJ_productSeller unique (CNPJ)
);

-- Create order table
create table orders(
	idOrders int auto_increment primary key,
    idOrdersClients int,
    ordersStatus enum("Cancelado", "Confirmado", "Em processamento") default "Em processamento" not null,
    orderDescription varchar(255),
    shipping float not null,
    trackingCode char(13),
    constraint fk_orders_clients foreign key (idOrdersClients) references clients(idClients)
);

-- Create association_clients_creditCard table
create table association_clients_creditCard(
	idAClients int,
    idACreditCard int,
    primary key (idAClients, idACreditCard),
	constraint fk_ACC_clients foreign key (idAClients) references clients(idClients),
    constraint fk_ACC_creditCard foreign key (idACreditCard) references creditCard(idCreditCard)
);

-- Create association_orders_product table
create table association_orders_product(
	idAOrders int,
    idAProduct int,
    quantity int default 1 not null,
    primary key (idAOrders, idAProduct),
	constraint fk_AOO_orders foreign key (idAOrders) references orders(idOrders),
    constraint fk_AOO_product foreign key (idAProduct) references product(idProduct)
);

-- Create association_product_supplier table
create table association_product_supplier(
	idAProduct int,
    idASupplier int,
    primary key (idAProduct, idASupplier),
	constraint fk_APS_product foreign key (idAProduct) references product(idProduct),
    constraint fk_APS_supplier foreign key (idASupplier) references supplier(idSupplier)
);

-- Create association_product_stock table
create table association_product_stock(
	idAProduct int,
    idAStock int,
    quantity int default 0 not null,
    primary key (idAProduct, idAStock),
	constraint fk_APStock_product foreign key (idAProduct) references product(idProduct),
    constraint fk_APStock_stock foreign key (idAStock) references stock(idStock)
);

-- Create association_product_productSeller table
create table association_product_productSeller(
	idAProduct int,
    idAProductSeller int,
    quantity int default 0 not null,
    primary key (idAProduct, idAProductSeller),
	constraint fk_APP_product foreign key (idAProduct) references product(idProduct),
    constraint fk_APP_productSeller foreign key (idAProductSeller) references productSeller(idProductSeller)
);