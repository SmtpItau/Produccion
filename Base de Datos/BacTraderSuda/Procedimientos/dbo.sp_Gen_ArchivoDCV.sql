USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Gen_ArchivoDCV]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_Gen_ArchivoDCV]  
@NomArchivo as varchar(8) ,  
@Usuario as varchar(10),  
@Estacion as varchar(50)  
AS  
/***********************************************************************  
NOMBRE         : dbo.sp_Gen_ArchivoDCV.StoredProcedure.sql  
AUTOR          : SONDA (Unidad de Desarrollo)  
FECHA CREACION : 09/08/2011  
DESCRIPCION    : Migracion a SQL 2008  
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
----------------------------------------------------------------------  
  
  
**********************************************************************/  
  
DECLARE @Correlativo AS NUMERIC(9)  
DECLARE @strFormat AS VARCHAR(3)  
DECLARE @strValFor AS VARCHAR(3)  
  
SET @Correlativo=1  
SET NOCOUNT ON  
  
SET @strFormat='00'  
SET @Correlativo=(SELECT COUNT(ADCV_Correlativo)AS N FROM ARCH_DCV WHERE DATEDIFF(DAY,ADCV_Fecha_Gen,GETDATE())=0)+1  
SET @strValFor=SUBSTRING(@strFormat,1,LEN(@strFormat)-LEN(@Correlativo)) + CAST(@Correlativo AS VARCHAR(3))  
SET @NomArchivo=@NomArchivo + @strValFor  
INSERT INTO ARCH_DCV VALUES(getdate(),@Correlativo,@NomArchivo,@Usuario,@Estacion)  
SELECT * FROM ARCH_DCV WHERE IDARCHIVODCV=@@IDENTITY  
SET NOCOUNT OFF  

GO
