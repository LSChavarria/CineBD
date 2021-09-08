--CREATE DATABASE BaseDatosCine
USE BaseDatosCine

CREATE TABLE Paises(
	Cve_Pais int NOT NULL IDENTITY(1, 1),
	Nombre_Pais varchar(60) UNIQUE,
	Abrev_Pais varchar(3) UNIQUE,
	PRIMARY KEY(Cve_Pais)
);

CREATE TABLE Estados(
	Cve_Estado int NOT NULL,
	Cve_Pais int,
	Nombre_Estado varchar(90) UNIQUE NOT NULL,
	FOREIGN KEY (Cve_Pais) REFERENCES Paises (Cve_Pais),
	PRIMARY KEY (Cve_Estado),
);

CREATE TABLE Municipios(
	Cve_Municipio int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Cve_Estado int,
	Cve_Pais int,
	Nombre_Municipio varchar(90) NOT NULL,
	FOREIGN KEY (Cve_Pais) REFERENCES Paises (Cve_Pais),
	FOREIGN KEY (Cve_Estado) REFERENCES Estados (Cve_Estado),
);

CREATE TABLE Codigo_Postal(
	Cve_CP int NOT NULL,
	Cve_Municipio int,
	Cve_Estado int,
	Cve_Pais int,
	Id_Colonia int NOT NULL,
	Colonia nvarchar(90) NOT NULL,
	PRIMARY KEY(Cve_CP),
	FOREIGN KEY (Cve_Pais) REFERENCES Paises (Cve_Pais),
	FOREIGN KEY (Cve_Estado) REFERENCES Estados (Cve_Estado),
	FOREIGN KEY (Cve_Municipio) REFERENCES Municipios (Cve_Municipio),
);

CREATE TABLE Sucursales(
	Cve_Sucursal int NOT NULL IDENTITY(1, 1),
	Nombre_Sucursal varchar(60) NOT NULL,
	Cve_CP int NOT NULL,
	Cve_Municipio int,
	Cve_Estado int,
	Cve_Pais int,
	Id_Colonia int NOT NULL,
	FOREIGN KEY (Cve_CP) REFERENCES Codigo_Postal(Cve_CP),
	FOREIGN KEY (Cve_Pais) REFERENCES Paises (Cve_Pais),
	FOREIGN KEY (Cve_Estado) REFERENCES Estados (Cve_Estado),
	FOREIGN KEY (Cve_Municipio) REFERENCES Municipios (Cve_Municipio),
	PRIMARY KEY(Cve_Sucursal)
);

CREATE TABLE Tipo_Sala(
	Cve_Tipo_Sala int NOT NULL IDENTITY(1, 1), 
	Descripcion_Sala nvarchar(60) NOT NULL,
	PRIMARY KEY(Cve_Tipo_Sala) 
);

CREATE TABLE Salas_Cine(
	Cve_Sala int NOT NULL,
	Cve_Sucursal int NOT NULL,
	Cve_Tipo_Sala int NOT NULL,
	Numero_Sala int,
	FOREIGN KEY (Cve_Sucursal) REFERENCES Sucursales (Cve_Sucursal),
	FOREIGN KEY (Cve_Tipo_Sala) REFERENCES Tipo_Sala (Cve_Tipo_Sala ),
	PRIMARY KEY(Cve_Sala)
);

CREATE TABLE Lugares_Sala_Cine(
	Cve_Lugar int NOT NULL,
	Cve_Sucursal int NOT NULL,
	Cve_Sala int NOT NULL,
	Cve_Tipo_Sala int NOT NULL, 
	Estatus int CHECK (Estatus=0 OR Estatus=1),
	FOREIGN KEY (Cve_Sucursal) REFERENCES Sucursales(Cve_Sucursal),
	FOREIGN KEY (Cve_Sala) REFERENCES Salas_Cine(Cve_Sala),
	FOREIGN KEY (Cve_Tipo_Sala) REFERENCES Tipo_Sala(Cve_Tipo_Sala ),
);

CREATE TABLE Idioma_Pelicula(
	Cve_Idioma int NOT NULL IDENTITY(1, 1),
	Nombre_Idioma varchar(90) UNIQUE,
	PRIMARY KEY (Cve_Idioma),
);

CREATE TABLE Categorias(
	Cve_Categoria int NOT NULL IDENTITY(1, 1),
	Nombre_Categoria varchar(90) UNIQUE,
	Descripcion nvarchar(90) NOT NULL,
	PRIMARY KEY(Cve_Categoria)
);

CREATE TABLE Peliculas(
	Cve_Pelicula int NOT NULL, 
	Nombre_Pelicula nvarchar(90) NOT NULL,
	Descripcion_Pelicula nvarchar(100) NOT NULL,
	Actores varchar(90),
	Duracion time,
	Studio nvarchar(90),
	Cve_Categoria int NOT NULL FOREIGN KEY (Cve_Categoria)  REFERENCES Categorias(Cve_Categoria),
	Cve_Idioma int NOT NULL FOREIGN KEY (Cve_Idioma) REFERENCES Idioma_Pelicula (Cve_Idioma), 
	PRIMARY KEY(Cve_Pelicula) 
);

CREATE TABLE Horarios(
	Cve_Horario int NOT NULL, 
	Nom_Dia varchar(10) CHECK(Nom_Dia='Lunes' OR Nom_Dia='Martes' OR Nom_Dia='Miercoles' OR Nom_Dia='Jueves' OR Nom_Dia='Viernes' OR Nom_Dia='Sabado' OR Nom_Dia='Domingo' ),
	Hora time,
	PRIMARY KEY(Cve_Horario ) 
);

CREATE TABLE Sala_Horario_Pelicula(
	Cve_Sucursal int NOT NULL,
	Cve_Sala int NOT NULL,
	Cve_Tipo_Sala int NOT NULL,
	Cve_Horario int NOT NULL,
	Cve_Pelicula int NOT NULL,
	Fecha_Inicial date,
	Fecha_Final date,
	Estatus int CHECK (Estatus=0 OR Estatus=1),
	FOREIGN KEY (Cve_Sucursal) REFERENCES Sucursales(Cve_Sucursal),
	FOREIGN KEY (Cve_Sala) REFERENCES Salas_Cine(Cve_Sala),
	FOREIGN KEY (Cve_Tipo_Sala) REFERENCES Tipo_Sala(Cve_Tipo_Sala ),
	FOREIGN KEY (Cve_Horario) REFERENCES Horarios(Cve_Horario),
	FOREIGN KEY (Cve_Pelicula) REFERENCES Peliculas(Cve_Pelicula),
	PRIMARY KEY (Cve_Sucursal,Cve_Sala,Cve_Tipo_Sala,Cve_Horario,Cve_Pelicula)
);

CREATE TABLE Clientes(
	Cve_cte int NOT NULL IDENTITY(1, 1),
	Nombre_cte varchar(90) NOT NULL,
	Apellido_Pat varchar(90) NOT NULL,
	Apellido_Mat varchar(90) NOT NULL,
	Direccion nvarchar(90), 
	Cve_CP int NOT NULL,
	Cve_Municipio int,
	Cve_Estado int,
	Cve_Pais int,
	Id_Colonia int NOT NULL,
	FOREIGN KEY (Cve_CP) REFERENCES Codigo_Postal (Cve_CP),
	FOREIGN KEY (Cve_Pais) REFERENCES Paises (Cve_Pais),
	FOREIGN KEY (Cve_Estado) REFERENCES Estados (Cve_Estado),
	FOREIGN KEY (Cve_Municipio) REFERENCES Municipios (Cve_Municipio),
	PRIMARY KEY(Cve_cte)
);

CREATE TABLE Costos_Cine(
	Cve_costo int NOT NULL IDENTITY(1, 1),
	Descripcion nvarchar(90) NOT NULL,
	Costo money,
	PRIMARY KEY (Cve_costo), 
);

CREATE TABLE Pago_Cliente(
	Codigo_Referencia int,
	Fecha_Pago date DEFAULT GETDATE(),
	Cve_cte int NOT NULL,
	Costo_Total_Cine money,
	Costo_Total_Productos money DEFAULT '0',
	Gran_Total money,
	Status_Cobro int DEFAULT '1',
	Cve_Sucursal int NOT NULL,
	Cve_Sala int NOT NULL,
	Cve_Tipo_Sala int NOT NULL,
	Cve_Horario int NOT NULL,
	Cve_Pelicula int NOT NULL,
	Status_Impresion int,
	Status_Reimpresion int DEFAULT '1',
	PRIMARY KEY (Codigo_Referencia),
	FOREIGN KEY (Cve_cte) REFERENCES Clientes (Cve_cte),
	FOREIGN KEY (Cve_Sucursal) REFERENCES Sucursales(Cve_Sucursal),
	FOREIGN KEY (Cve_Sala) REFERENCES Salas_Cine(Cve_Sala),
	FOREIGN KEY (Cve_Tipo_Sala) REFERENCES Tipo_Sala(Cve_Tipo_Sala ),
	FOREIGN KEY (Cve_Horario) REFERENCES Horarios(Cve_Horario),
	FOREIGN KEY (Cve_Pelicula) REFERENCES Peliculas(Cve_Pelicula)
);

CREATE TABLE Asignacion_Lugares(
	Codigo_Referencia int,
	Cve_Lugar int NOT NULL,
	Cve_Sucursal int NOT NULL,
	Cve_Sala int NOT NULL,
	Cve_Tipo_Sala int NOT NULL,
	FOREIGN KEY (Codigo_Referencia) REFERENCES Pago_Cliente (Codigo_Referencia),
	FOREIGN KEY (Cve_Sucursal) REFERENCES Sucursales (Cve_Sucursal),
	FOREIGN KEY (Cve_Sala) REFERENCES Salas_Cine(Cve_Sala),
	FOREIGN KEY (Cve_Tipo_Sala) REFERENCES Tipo_Sala(Cve_Tipo_Sala )
);

CREATE TABLE Detalle_Pago_Cliente(
	Codigo_Referencia int,
	Cve_Costo int NOT NULL,
	Costo_Boleto money,
	FOREIGN KEY(Cve_Costo) REFERENCES Costos_Cine(Cve_Costo),
	FOREIGN KEY(Codigo_Referencia) REFERENCES Pago_Cliente (Codigo_Referencia)
);