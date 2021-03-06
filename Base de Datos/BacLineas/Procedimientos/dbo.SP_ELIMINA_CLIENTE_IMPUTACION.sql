USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_CLIENTE_IMPUTACION]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINA_CLIENTE_IMPUTACION]
(  @Rut_Cliente       NUMERIC (9,0)
 , @Codigo_Cliente    NUMERIC (9,0)
) 
AS
BEGIN

  SET NOCOUNT ON    

  -- Prueba Cliente que no tiene familia:
  -- SP_ELIMINA_CLIENTE_IMPUTACION_8800_MAP 88,1  -- select * from CLIENTE_IMPUTANDO -- delete cliente_imputando where rut_Cliente <> 990005010

  -- Prueba Cliente Padre
  -- SP_ELIMINA_CLIENTE_IMPUTACION_8800_MAP 472655828,1  -- select * from CLIENTE_IMPUTANDO -- delete cliente_imputando where rut_Cliente = 88

  -- Prueba Cliente Hijo
  -- SP_ELIMINA_CLIENTE_IMPUTACION_8800_MAP 990005010 ,1  -- select * from CLIENTE_IMPUTANDO -- delete cliente_imputando where rut_Cliente = 88


   -- Eliminar a toda la familia.
  CREATE TABLE #FAMILIA
           (
             Id                 VARCHAR(19) ,
             ClRut              numeric(13),
             ClCodigo           numeric(5),
             Afecta_Lineas_Hijo numeric(1)
           )

   INSERT INTO #FAMILIA
            EXECUTE BacLineas..SP_RIEFIN_FAMILIAS @Rut_Cliente, @Codigo_Cliente

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

   Select  *, Eliminado = '  ' into 
   #CLIENTE_IMPUTACION 
   from CLIENTE_IMPUTANDO where 1 <> 1

   While @i <= @Ultimo 
   Begin   
       Select   @Rut_Cliente    = ClRut
              , @Codigo_Cliente = ClCodigo
       from  #ArregloFamilia 
       where Correlativo = @i

		-- Poner esto como invariante
		IF EXISTS (SELECT 1 FROM DBO.CLIENTE_IMPUTANDO WHERE  Rut_Cliente = @Rut_Cliente AND Codigo_Cliente = @Codigo_Cliente  ) 
		BEGIN
			DELETE 
			FROM DBO.CLIENTE_IMPUTANDO 
			WHERE Rut_Cliente = @Rut_Cliente 
			AND   Codigo_Cliente = @Codigo_Cliente	
			insert into #CLIENTE_IMPUTACION SELECT @Rut_Cliente,  @Codigo_Cliente, 'SI'       
		END	
		ELSE 
		BEGIN  
			insert into #CLIENTE_IMPUTACION SELECT @Rut_Cliente,  @Codigo_Cliente, 'NO'       
		END 
		-- Poner esto como invariante

        Set @i = @i + 1       

  End        

  declare @FaltoBorrar varchar(2) 
  set     @FaltoBorrar = 'NO'
  select  @FaltoBorrar = Case when Eliminado = 'NO' then 'SI' else 'NO' end
   from   #CLIENTE_IMPUTACION

  if @FaltoBorrar = 'SI'          
     select 'NO EXISTE'
  else
     select 'OK'


  RETURN

  SET NOCOUNT OFF

END
GO
