USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_AYUDAPLANILLA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_AYUDAPLANILLA]( @Tabla  VARCHAR(40) = '')
AS
BEGIN
     DECLARE @Aux  VARCHAR(10)
     SET NOCOUNT ON
     ----<< Monedas
/*     IF @Tabla IN ( 'MONEDA', 'MONEDAS')
        SELECT 'Tabla' = 0, 'BCCH' = mncodbanco, 'Nemo' = mnsimbol, 'Glosa' = mnglosa 
             , 'PaisBCCH' = (CASE ISNULL(p.codigoBCCH,0) WHEN 0 THEN 225 ELSE p.codigoBCCH END)   -- 225.USA
          FROM mdmn, view_Pais p
         WHERE mnmx = 'C' */    -- /* OR mncodsuper < 141*/   
/*           AND codigo_pais *= p.codigo
         ORDER BY mncodmon
*/
     ----<< Instituciones Financieras
     IF @Tabla IN ( 'INSTITUCION', 'INSTITUCIONES')
        SELECT 'Tabla' = 0, 'BCCH' = ISNULL(clcodban,0), 'Nemo' = clgeneric, 'Glosa' = clnombre 
          FROM view_cliente   WHERE clcodban > 0   ORDER BY clcodban
     ----<< Pais
     IF @Tabla IN ( 'PAIS', 'PAISES')
        SELECT 'Tabla' = 0, 'BCCH' = codigo_pais /*codigoBCCH*/, 'nemo' = nombre, nombre
          FROM view_Pais   WHERE codigo_pais /*codigoBCCH*/> 0   ORDER BY codigo_pais /*codigoBCCH*/
     ----<< Codigos OMA segun tipo de documento
     IF @Tabla LIKE '%OPERACIONESXDOCUMENTO'   BEGIN
        SELECT @Aux = LEFT(@Tabla,1)
 -- Transferencia ingreso es igual a Posicion ingreso
        IF @Aux = '9'
           SELECT @Aux = '1'
 -- Egreso Transferencia o Anulacion (10,11,12) es igual a Egreso Posicion o Anulacion (2,3,4)
        IF CHARINDEX( SUBSTRING(@Tabla,2,1) , '012' ) > 0
           SELECT @Aux = CONVERT(CHAR(1), CONVERT(NUMERIC(2), LEFT(@Tabla,2)) - 8 )
        SELECT 'Tabla' = 0, 'BCCH' = codigo_numerico, 'tipo_documento' = SUBSTRING(codigo_caracter,1,1), glosa
          FROM view_tbCodigoOMA   
         WHERE @Aux = SUBSTRING(codigo_caracter,1,1)   
         ORDER BY codigo_numerico
     END
     ----<< Formas de Pago
     IF @Tabla IN ( 'FORMAPAGO', 'FORMASPAGO')
        SELECT 'Tabla' = 0, 'BCCH' = codigo, 'Nemo' = glosa2, glosa
          FROM VIEW_FORMA_DE_PAGO
END



GO
