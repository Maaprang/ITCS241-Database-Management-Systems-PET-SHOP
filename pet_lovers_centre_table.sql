
CREATE TABLE Manager_table /*FULL DATADE | Create ready*/
(

	Manager_id	 CHAR(6)		  NOT NULL UNIQUE,
	Manager_name NVARCHAR(50) NOT NULL UNIQUE,
	Education	NVARCHAR(50)     ,
	Experience  NVARCHAR(50)	 ,
	Workplace   NVARCHAR(50)   NOT NULL,
	Work_hours  int            NOT NULL,
	PRIMARY KEY (Manager_id),
);
create table Customer_name_table /* part on customer_table | Create ready*/
(
	Citizen_id	nvarchar(20)    not null unique,
	C_name	nvarchar(50)    not null,
	Sex			nvarchar(20)	,
	Birthday	date			,
	C_address	nvarchar(50)    ,
	primary key (Citizen_id)

);

create table Customer_table /* Not FULL* | Create ready*/
(
	C_id		char(5)			not null unique,
	Citizen_id	nvarchar(20)    not null,
	Phone_number nvarchar(20)	not null,
	Email		nvarchar(50)	,
   primary key (C_id),
   FOREIGN Key (Citizen_id) REFERENCES Customer_name_table(Citizen_id) ON Update cascade

	
);


create table Stock_table /* FULL | Create ready*/
(
	S_id		char(5)			not null unique,
	S_name		nvarchar(50)	not null,
	S_location	nvarchar(50)	not null,
	S_capacity	int				,
	S_type		nvarchar(50)	,
	S_status	nvarchar(50)    not null,
	primary key(S_id)
);
create table Branch_manager_table  /* Create ready*/
(
    Manager_id			char(6)			NOT NULL unique,
	Manager_name		nvarchar(50)	,
	primary key(Manager_id),

	
);
create table Branch_time_table  /* Create ready*/
(
    Branch_name			NVARCHAR(50)	NOT NULL unique,
	Working_hour		NVARCHAR(20)	NOT NULL ,
	Working_day			NVARCHAR(20)	NOT NULL,
	primary key(Branch_name)

);
CREATE TABLE Branch_table /* not full*/ /* Create ready*/
(
    Branch_id			CHAR(5)			NOT NULL UNIQUE,
	Branch_name			NVARCHAR(50)	NOT NULL,
	Branch_location		NVARCHAR(50)	NOT NULL,
	Branch_telephone	NVARCHAR(20)    NOT NULL,
	Branch_email		NVARCHAR(50)    NOT NULL,
	Branch_fax_num		NVARCHAR(20)	NOT NULL,
	Manager_id			char(6)			NOT NULL,
	PRIMARY Key(Branch_id),
	FOREIGN Key (Manager_id) REFERENCES Branch_manager_table(Manager_id) ON Update cascade,
    FOREIGN Key (Branch_name) REFERENCES Branch_time_table(Branch_name) ON Update cascade

);
create table Membership_customer_table /* Create ready*/
(
	C_id		char(5)			NOT NULL unique,
	Mem_number	nvarchar(50)	not null,
	Mem_firstdate date			not null,
	Mem_enddate   date			not null,
	primary key(C_id)
);

CREATE TABLE Membership_table /* not full*/ /* Create ready*/
(
	Mem_id		CHAR(5)			NOT NULL UNIQUE,
	Mem_number	nvarchar(50)	not null,
	C_id		char(5)			NOT NULL,
	PRIMARY Key (Mem_id),
	foreign key (C_id) references Membership_customer_table(C_id) ON Update cascade
	
	
);
create table Employee_name_table /* Create ready*/
(
    Citizen_id	nvarchar(50)	not null unique,
	Firstname	nvarchar(50)	not null,
	Surname		nvarchar(50)	not null,
	Sex			nvarchar(20)	,
	Birthday	date		,
	primary key(Citizen_id)
	
);
create table Employee_table /*not full*/
(
	Em_id		char(5)			not null unique,
	Citizen_id	nvarchar(50)	not null,
    Email		nvarchar(50)	,
	Phone_number nvarchar(20)	,
	Wage		float			not null,
	Check_in	nvarchar(20)			not null,
	Check_out	nvarchar(20)		not null,
	All_hour	int				not null,
	primary key (Em_id),
	foreign key (Citizen_id) references Employee_name_table(Citizen_id) ON Update cascade



);

create table Promotion_table /*full */
(
	Promo_id		char(6)		not null unique,
	Promo_member	nvarchar(50) not null,
	Promo_discount	float		,
	Promo_status	nvarchar(20)  not null,
	Net_price		float		,
	primary key (Promo_id)
);

create table Stock_product_table
(
     S_id		CHAR(5)			NOT NULL unique,
	 P_name		nvarchar(50)    not null,
	 primary key (S_id)
);
CREATE TABLE Product_table( /*not full*/
	P_id		CHAR(5)			NOT NULL UNIQUE,
	P_type		NVARCHAR(20)		NOT NULL,
	P_name		NVARCHAR(50)		NOT NULL,
	P_detail	NVARCHAR(50)		,
	P_price		float				NOT NULL,
	S_id		CHAR(5)			NOT NULL,
	PRIMARY KEY (P_id),
	foreign key (S_id) references Stock_table(S_id) ON Update Cascade
	
	
);


create table Order_table /*full*/
(
    
	Order_id		char(5)		not null unique,
	Order_date		date		,
	Order_last		date		,
	Net_price		float		not null,
	Order_status	nvarchar(20)	not null,
	primary key(Order_id)
);
create table Payment_order_table
(
	Order_id	char(5)    not null unique,
	Amount      float		not null,
	Pm_status   nvarchar(20) not null,
	primary key(Order_id),
	
	
);
create table Payment_table
(
    Pm_id		char(6)		   not null unique,
	c_id		char(5)   not null,
	Cash_date   date		   not null,
	Pm_type		nvarchar(50)   not null,
	bank_transfer_status  nvarchar(20) ,
	Order_id	char(5)    not null ,
	
	primary key(Pm_id),
	foreign key(Order_id) references Payment_order_table(Order_id) ON Update Cascade
);

