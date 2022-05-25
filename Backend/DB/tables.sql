/**
USE MASTER
DROP DATABASE INVENTARIO_IACSA
CREATE DATABASE INVENTARIO_IACSA
**/
USE INVENTARIO_IACSA
GO

USE INVENTARIO_IACSA
GO 
CREATE TABLE USUARIOS(
	ID_USUARIO		SMALLINT IDENTITY(1,1)		NOT NULL,
	CORREO			VARCHAR(50)	NOT NULL

	CONSTRAINT PK_USUARIOS PRIMARY KEY (ID_USUARIO)
	CONSTRAINT CHK_CORREO_USUARIO CHECK (CORREO LIKE '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%')
);

GO

CREATE TABLE NOMBRE_USUARIO(
	ID_USUARIO SMALLINT IDENTITY(1,1) 	NOT NULL,
	NOMBRE VARCHAR(50) NOT NULL,
	APELLIDO1 VARCHAR(50) NOT NULL,
	APELLIDO2 VARCHAR(50) NOT NULL
	
	CONSTRAINT FK_NOMBREUSUARIO FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO),
	CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO)
);

GO

CREATE TABLE MENSAJES(
	--ID_MENSAJE VA A SER DEL MISMO ID DEL USUARIO
	ID_MENSAJE		SMALLINT IDENTITY(1,1)		NOT NULL,
	-- PUEDE SER NULL YA QUE LA MAQUINA ENVIA MENSAJES
	ID_REMITENTE	SMALLINT		NULL,
	ID_DESTINATARIO	SMALLINT		NOT NULL,
	ASUNTO			VARCHAR(75)		NOT NULL DEFAULT 'NO ASUNTO',
	CONTENIDO		VARCHAR(280)	NOT NULL

	CONSTRAINT PK_MENSAJES PRIMARY KEY (ID_MENSAJE),
	CONSTRAINT FK_REMITENTEMENSAJES FOREIGN KEY (ID_REMITENTE) REFERENCES USUARIOS(ID_USUARIO),
	CONSTRAINT FK_DESTINATARIOMENSAJES FOREIGN KEY (ID_DESTINATARIO) REFERENCES USUARIOS(ID_USUARIO)
);

GO


CREATE TABLE AREA(
	NOMBRE			CHAR(30)		NOT NULL,
	LOGO			VARCHAR(50)		NULL,
	ENCARGADO		SMALLINT		NOT NULL,	--EL ENCARGADO ES EL ID DEL AREA
	ID_INSTITUCION SMALLINT 		NOT NULL
	CONSTRAINT PK_AREA PRIMARY KEY (NOMBRE),
	CONSTRAINT FK_ENCARGADO_AREA FOREIGN KEY (ENCARGADO) REFERENCES USUARIOS(ID_USUARIO)
	
);

GO

CREATE TABLE UBICACIONES(
	ID_UBICACION	SMALLINT	IDENTITY(1,1)	NOT NULL,
	DETALLE			VARCHAR(50)		NULL,
	NOMBRE			VARCHAR(50)		NOT NULL

	CONSTRAINT PK_UBICACIONES PRIMARY KEY (ID_UBICACION)
	);

GO

CREATE TABLE ACTIVOS(
	ID_ACTIVO		SMALLINT	IDENTITY(1,1)	NOT NULL,
	AREA_NOMBRE		CHAR(30)		NOT NULL, 
	ID_UBICACION	SMALLINT		NOT NULL
	CONSTRAINT PK_ACTIVOS PRIMARY KEY (ID_ACTIVO),
	CONSTRAINT FK_AREANOMBRE_ACTIVO FOREIGN KEY (AREA_NOMBRE) REFERENCES AREA(NOMBRE),
	CONSTRAINT FK_ACTIVO_UBICACION FOREIGN KEY (ID_UBICACION) REFERENCES UBICACIONES(ID_UBICACION)
);

GO
--Atributo de Activo
CREATE TABLE TIPOS(
	ID_ACTIVO		SMALLINT	IDENTITY(1,1)	NOT NULL,
	PLACA			INT				NOT NULL,
	DESCRIPCION		VARCHAR(150)	NULL DEFAULT 'NO DESCRIPCION',
	GARANTIA		VARCHAR(20)		NULL,

	CONSTRAINT FK_TIPOS FOREIGN KEY (ID_ACTIVO) REFERENCES ACTIVOS(ID_ACTIVO),
	CONSTRAINT PK_TIPOS PRIMARY KEY (ID_ACTIVO)
);

GO


--LLEVAR UN CONTROL DE LOS ACTIVOS

CREATE TABLE CONTROL_ACTIVOS(
	ID_ACTIVO		SMALLINT IDENTITY(1,1)		NOT NULL,	
	ESTADO_ACTIVO	VARCHAR(30)		NOT NULL,
	FECHA_CONTROL	DATE			NOT NULL,
	
	CONSTRAINT FK_CONTROLACTIVOS_AREA FOREIGN KEY (ID_ACTIVO) REFERENCES ACTIVOS(ID_ACTIVO),
	CONSTRAINT PK_CONTROL_ACTIVOS PRIMARY KEY (ID_ACTIVO)
);

GO





CREATE TABLE INSTITUCIONES(
	ID_INSTITUCION	TINYINT	IDENTITY(1,1)		NOT NULL,
	ID_UBICACION	SMALLINT		NOT NULL,	--UBICACIONES HAY QUE GENERARLO PREVIAMENTE
	NOMBRE			VARCHAR(50)		NOT NULL,
	CORREO			VARCHAR(30)		NOT NULL,

	CONSTRAINT PK_INSTITUCIONES PRIMARY KEY (ID_INSTITUCION),
	CONSTRAINT FK_INSTITUCION_UBICACION FOREIGN KEY (ID_UBICACION) REFERENCES UBICACIONES(ID_UBICACION),
	CONSTRAINT CHK_CORREO_INST CHECK (CORREO LIKE '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%')
);

GO

CREATE TABLE TELEFONOS(
	ID_INSTITUCION	TINYINT	IDENTITY(1,1)		NOT NULL,
	NUMERO			CHAR(8)	UNIQUE	NOT NULL,

	CONSTRAINT FK_TELEFONOS FOREIGN KEY (ID_INSTITUCION) REFERENCES INSTITUCIONES(ID_INSTITUCION),
	CONSTRAINT PK_TELEFONOS PRIMARY KEY (ID_INSTITUCION),
	CONSTRAINT CHK_NUMERO CHECK (NUMERO LIKE ('[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
)

GO

CREATE TABLE PRESTAMOS(
	ID_PRESTAMO		SMALLINT IDENTITY(1,1)		NOT NULL,
	ID_ACTIVO 		SMALLINT					NOT NULL,	
	ESTADO			BIT							NOT NULL DEFAULT 1,
	TIEMPO_PR		DATE						NOT NULL,
	FECHA_SO		DATE						NOT NULL DEFAULT GETDATE(),
	FECHA_DE		DATE						NOT NULL DEFAULT GETDATE()+31

	CONSTRAINT PK_PRESTAMOS PRIMARY KEY (ID_PRESTAMO),
	CONSTRAINT FK_PRESTAMOSACTIVOS FOREIGN KEY (ID_ACTIVO) REFERENCES ACTIVOS(ID_ACTIVO)
)

GO


CREATE TABLE SOLICITANTE(
	ID_PRESTAMO SMALLINT IDENTITY(1,1)	NOT NULL,
	ID_USUARIO SMALLINT		NOT NULL,

	CONSTRAINT FK_SOLICITANTEPRESTAMO FOREIGN KEY (ID_PRESTAMO) REFERENCES PRESTAMOS(ID_PRESTAMO),
	CONSTRAINT FK_SOLICITANTEUSUARIO FOREIGN KEY (ID_USUARIO)   REFERENCES USUARIOS(ID_USUARIO),
	CONSTRAINT PK_SOLICITANTE PRIMARY KEY (ID_PRESTAMO)
)

GO



