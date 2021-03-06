USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLANILLA_OPERACION]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PLANILLA_OPERACION] (@condicion VARCHAR (10))
AS
BEGIN
 SET NOCOUNT OFF
 SELECT  a.comercio       
        ,a.concepto       
        ,ISNULL(b.glosa,'NO EXISTE CODIGO COMERCIO')   
        ,a.tipo_documento      
        ,a.tipo_operacion_cambio 
   FROM  codigo_planilla_automatica  a  
         LEFT JOIN codigo_comercio   b 
ON  a.comercio = b.codigo_relacion 
  WHERE  a.condicion = @condicion        
-- AND a.concepto *= b.concepto )
 
 SET NOCOUNT ON
END
-- select * from codigo_planilla_automatica where condicion='VCLP1'
-- sp_planilla_operacion 'VCLP1'

GO
