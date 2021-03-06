USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_CLIENTE_IMPUTACION]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INSERTA_CLIENTE_IMPUTACION]
(  @Rut_Cliente       NUMERIC (9,0)
 , @Codigo_Cliente    NUMERIC (9,0)
) 
AS
BEGIN

  SET NOCOUNT ON
  -- Prueba Cliente que no tiene familia:
  -- SP_INSERTA_CLIENTE_IMPUTACION_8800 88,1  -- select * from CLIENTE_IMPUTANDO -- delete cliente_imputando where rut_Cliente <> 990005010

  -- Prueba Cliente Padre
  -- SP_INSERTA_CLIENTE_IMPUTACION_8800 472655828,1  -- select * from CLIENTE_IMPUTANDO -- delete cliente_imputando where rut_Cliente = 88

  -- Prueba Cliente Hijo
  -- SP_INSERTA_CLIENTE_IMPUTACION_8800 990005010 ,1  -- select * from CLIENTE_IMPUTANDO -- delete cliente_imputando where rut_Cliente = 88

  -- SP_INSERTA_CLIENTE_IMPUTACION_8800 99532330, 1

  -- Se debe bloquear a toda la familia
  CREATE TABLE #FAMILIA
           (
             Id                 VARCHAR(19) ,
             ClRut              numeric(13),
             ClCodigo           numeric(5),
             Afecta_Lineas_Hijo numeric(1)
           )

   INSERT INTO #FAMILIA
            EXECUTE BacLineas..SP_RIEFIN_FAMILIAS @Rut_Cliente, @Codigo_Cliente

   declare @HayTipoFFMM  varchar(2)
   select  @HayTipoFFMM  = 'NO'
   select  @HayTipoFFMM = case when Afecta_Lineas_Hijo = 1 then 'SI' else 'NO' end
   from #FAMILIA where Afecta_Lineas_Hijo = 1

   if @HayTipoFFMM = 'SI' 
   begin
      select 'FFMM'
      return
   end   
   select  
           Correlativo  = identity(Int, 1,1) 
         , Id       = Id
         , ClRut    = ClRut
         , ClCodigo = ClCodigo
         , Afecta_Lineas_Hijo
     into  #ArregloFamilia
     from  #FAMILIA

   declare @i numeric(10)
   declare @Ultimo numeric(10)
   Set     @i = 1
   Select  @Ultimo = max( Correlativo ) from #ArregloFamilia

   select *, Bloqueado = '  ' into #CLIENTE_IMPUTANDO from CLIENTE_IMPUTANDO where 1 <> 1   --- select * from CLIENTE_IMPUTANDO

   While @i <= @Ultimo 
   Begin   
       Select   @Rut_Cliente    = ClRut
              , @Codigo_Cliente = ClCodigo
       from  #ArregloFamilia 
       where Correlativo = @i

	   IF NOT EXISTS (SELECT 1 FROM DBO.CLIENTE_IMPUTANDO WHERE  Rut_Cliente = @Rut_Cliente AND Codigo_Cliente = @Codigo_Cliente  )  
	   BEGIN 
		 INSERT INTO #CLIENTE_IMPUTANDO
		 select     @Rut_Cliente
		          , @Codigo_Cliente
                  , 'OK' 
		        
	   END
	   ELSE 
	   BEGIN 
		 INSERT INTO #CLIENTE_IMPUTANDO
		 select     @Rut_Cliente
		           , @Codigo_Cliente
                   , 'NO' 
		        
	   END
       Set @i = @i + 1       
    End        
  -- Verificar si hay clientes no bloqueado
  declare @HayNoBloqueados varchar(2)
  set     @HayNoBloqueados  = 'NO'
  select  @HayNoBloqueados  = Case when Bloqueado = 'NO' then 'SI' else 'NO' end 
  from #CLIENTE_IMPUTANDO where Bloqueado = 'NO'

  -- Verificar si todos se pudieron bloquear
  if @HayNoBloqueados = 'NO' 
    begin
       insert into CLIENTE_IMPUTANDO select Rut_Cliente,  Codigo_Cliente 
       from #CLIENTE_IMPUTANDO
       Select 'OK'
    end
  else
       Select 'NO'
  SET NOCOUNT OFF
--  SELECT 'NO'  o SELECT 'OK'  , formato de salida final 
END
GO
