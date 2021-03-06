USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TASASMTM]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_TasasMTM    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_TasasMTM    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[SP_LEER_TASASMTM]
            ( 
              @codmoneda integer = 0 ,
              @codtasa   integer = 0 ,
              @desde     integer = 0 ,
              @fecha     char(8) = ''
            )
AS   
BEGIN
        
     IF @fecha = ''
        SELECT @fecha = convert(char(8),fechaproc,112) FROM SWAPGENERAL
     SELECT desde     ,     --  1
            bid       , 
            offer     , 
            tasa      ,  --  2- 3-4
            base      , 
            baseconv  ,  --  5- 6
            tasafinal ,
            tasazcr   ,                --  7- 8
            codigomoneda,                       --  9
            isnull(a.mnglosa,'******'),         -- 10
            isnull(a.mnnemo,'***'),             -- 11
            codigotasa ,                         -- 12
            isnull(b.tbglosa,'******'),  -- 13
            'Fecha'=CONVERT(CHAR(10),fecha,103) -- 14
       FROM TASA  
            LEFT JOIN MONEDA    a ON  codigomoneda = a.mncodmon
            LEFT JOIN TABLA_GENERAL_DETALLE b ON b.tbcateg = 42 and codigotasa = b.tbcodigo1
      WHERE (codigomoneda = @codmoneda or @codmoneda =  0)
        and (codigotasa   = @codtasa   or @codtasa   =  0)
        and (desde        = @desde     or @desde     =  0)
        and  fecha        = @fecha
     ORDER BY desde
END

GO
