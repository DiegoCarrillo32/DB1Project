CREATE OR ALTER TRIGGER [dbo].[ACTIVO_TRIGGER]
ON  [dbo].[ACTIVOS]
AFTER INSERT
AS
BEGIN
    DECLARE @ID_ACTIVO SMALLINT
    SELECT @ID_ACTIVO = ID_ACTIVO FROM INSERTED
    INSERT INTO CONTROL_ACTIVOS(ID_ACTIVO, ESTADO_ACTIVO, FECHA_CONTROL) VALUES (
        @ID_ACTIVO, 
        'ACTIVO',
        DATEADD(YEAR, 1, GETDATE())
    )
END
