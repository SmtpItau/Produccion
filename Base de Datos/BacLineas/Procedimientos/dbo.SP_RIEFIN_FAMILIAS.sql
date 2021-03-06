USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_FAMILIAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_FAMILIAS] 
 (  
      @Rut   NUMERIC(13) = 0
    , @Codigo NUMERIC(3) = 0
 )
As BEGIN

-- SP_RIEFIN_FAMILIAS 472655828, 1
-- SP_RIEFIN_FAMILIAS 98001000, 1
-- SP_RIEFIN_FAMILIAS 96767630,1 
-- SP_RIEFIN_FAMILIAS 4455566,1 

        set nocount on
        declare @CntFamilia numeric(5)

        -- Carga en tabla #FAMILIA el rut del padre si @rut es padre
        Select Id = rtrim( Convert( varchar( 14) , ClRut_Padre ) ) + rtrim( convert( varchar(5), ClCodigo_Padre ) )
             , ClRut    = ClRut_Padre
             , ClCodigo = ClCodigo_Padre
             , Afecta_Lineas_Hijo 
        into #Familia
         from BacLineas..CLIENTE_RELACIONADO  --  select * from BacLineas..CLIENTE_RELACIONADO 
        where ClRut_padre = @Rut and ClCodigo_Padre = @Codigo -- Pensamos que @rut es padre
        union
        -- Carga en tabla #FAMILIA el rut del hijo si @rut es hijo
        Select Id = rtrim( Convert( varchar( 14) , ClRut_Padre ) ) + rtrim( convert( varchar(5), ClCodigo_Padre ) )
             , ClRut    = ClRut_Padre
             , ClCodigo = ClCodigo_Padre
             , Afecta_Lineas_Hijo
         from BacLineas..CLIENTE_RELACIONADO 
        where ClRut_Hijo = @Rut and ClCodigo_Hijo = @Codigo   -- pensamos que @rut es hijo
        -- Se gregan en #Familia todos los hijos del padre
        insert into #Familia
        Select Id = rtrim( Convert( varchar( 14) , ClRut_Hijo ) ) + rtrim( convert( varchar(5), ClCodigo_Hijo ) )
             , ClRut    = ClRut_Hijo
             , ClCodigo = ClCodigo_Hijo
             , Afecta_Lineas_Hijo = Hijo.Afecta_Lineas_Hijo
          from BacLineas..CLIENTE_RELACIONADO Hijo
               , #FAMILIA Padre where Padre.ClRut = Hijo.ClRut_Padre and Padre.ClCodigo = Hijo.ClCodigo_Padre
 
        Set @CntFamilia = 0
        select @CntFamilia =  count(1) from #familia
        if @CntFamilia = 0 
        begin
           insert into  #Familia
           Select Id    = rtrim( Convert( varchar( 14) , @Rut ) ) + rtrim( convert( varchar(5), @Codigo ) )
             , ClRut    = @Rut
             , ClCodigo = @Codigo   
             , Afecta_Lineas_Hijo = 0        
        end
        Select * from #Familia        
END
GO
