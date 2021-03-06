USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZ_ATRIBUCIONES_OPERADOR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MATRIZ_ATRIBUCIONES_OPERADOR]
		(
						@Usuario	CHAR(15)
							)
AS BEGIN
   SET NOCOUNT ON



	
      CREATE TABLE #TEMP
  (    Operador		    CHAR(15)        NOT NULL	
   ,   Nombre_Operador      CHAR(40)        NOT NULL
   ,   Sistema		    CHAR(03)        NOT NULL		
   ,   Codigo_Prod          CHAR(12)        NOT NULL
   ,   Glosa_Prod           CHAR(35)        NOT NULL
   ,   Monto_Max_Operacion  NUMERIC(19,4)   NOT NULL
   ,   Monto_Max_Diario     NUMERIC(19,4)   NOT NULL
   ,   Monto_Acum_Diario    NUMERIC(19,4)   NOT NULL
   ,   Saldo_Diario         NUMERIC(19,4)   NOT NULL
   )

 
        insert into #temp         
	select  a.usuario  
	       ,isnull((select  nombre from VIEW_USUARIO b where   a.Usuario = b.usuario),'')	
       	       ,a.Id_Sistema
	       ,a.Codigo_Producto	       
	       ,b.Glosa_Grupo	
	       ,a.Monto_Maximo_Operacion
	       ,a.Monto_Maximo_Acumulado
	       ,a.Acumulado_Diario
	       ,a.Monto_Maximo_Acumulado - a.Acumulado_Diario 	 				
	
	from MATRIZ_ATRIBUCION_INSTRUMENTO a ,
	     GRUPO_PRODUCTO b,
	     VIEW_USUARIO c

	where   a.Id_Sistema = b.Id_Sistema   AND
		a.Codigo_Producto =b.Codigo_Grupo AND
		(@Usuario =' ' or a.Usuario=@Usuario)AND
		a.Usuario =  c.usuario and 
		c.tipo_usuario in('TRADER','SUPERVISOR')
	GROUP BY a.Usuario 
        	,a.Id_Sistema
	        ,a.Codigo_Producto	       
	        ,b.Glosa_Grupo	
	        ,a.Monto_Maximo_Operacion
	        ,a.Monto_Maximo_Acumulado
	        ,a.Acumulado_Diario 				


	delete #TEMP where Nombre_Operador =''


	select *  from  #TEMP

SET NOCOUNT OFF
END
GO
