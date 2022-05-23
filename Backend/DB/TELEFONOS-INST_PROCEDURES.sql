CREATE PROC INSERT_TELEFONOS(@ID_INSTITUCION INSTITUCIONES,@NUMERO TELEFONOS)
AS
    INSERT INTO TELEFONOS(ID_INSTITUCION,NUMERO) VALUES(
        @ID_INSTITUCION,@NUMERO

    )

GO

CREATE PROC DELETE_TELEFONOS(@ID_INSTITUCION INSTITUCIONES,@NUMERO TELEFONOS)
AS
    DELETE FROM TELEFONOS
    WHERE @ID_INSTITUCION = ID_INSTITUCION

GO

CREATE PROC UPDATE_TELEFONOS(@ID_INSTITUCION INSTITUCIONES,@NUMERO TELEFONOS)
AS
    UPDATE TELEFONOS
    SET 
    [NUMERO] = @NUMERO
    WHERE @ID_INSTITUCION = ID_INSTITUCION AND @NUMERO = NUMERO

GO