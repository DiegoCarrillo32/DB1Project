USE INVENTARIO_IACSA

GO

CREATE OR ALTER VIEW ACTIVO_AREA_UBICACION_VIEW
AS 

        
        SELECT ACTIVOS.NOMBRE_ACTIVO, UBICACIONES.ID_UBICACION, AREA.NOMBRE, AREA.ENCARGADO, CONCAT(NOMBRE_USUARIO.NOMBRE, ' ', NOMBRE_USUARIO.APELLIDO1, ' ', NOMBRE_USUARIO.APELLIDO2) AS 'NOMBRE DE ENCARGADO' FROM ACTIVOS 
        INNER JOIN AREA 
            ON AREA.ID_AREA = ACTIVOS.ID_AREA
        INNER JOIN UBICACIONES 
            ON ACTIVOS.ID_UBICACION = UBICACIONES.ID_UBICACION
        INNER JOIN NOMBRE_USUARIO
            ON AREA.ENCARGADO = NOMBRE_USUARIO.ID_USUARIO
    
GO

SELECT * FROM ACTIVO_AREA_UBICACION_VIEW
GO
SELECT * FROM PRESTAMOS

