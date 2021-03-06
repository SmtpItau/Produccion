USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_Condiciones_Generales_Legal_Opciones]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_Condiciones_Generales_Legal_Opciones]
   (   @CliRut      numeric(9)
     , @CliCodigo   numeric(9)
     , @Usuario VarChar(15) 
     , @RutRepCli01 numeric(9) = 0 
     , @RutRepCli02 numeric(9) = 0 
     , @RutRepBan01 numeric(9) = 0 
     , @RutRepBan02 numeric(9) = 0 
   )
AS 
BEGIN

     -- INSTRUCCIONES GENERALES DE MANTENCION
     -- @RutRep01 numeric(9) , @RutRep02 numeric(9) corresponden a los rut de rep legales
     -- que puede que no haya.

     /* select * from caencContrato
        SP_Condiciones_Generales_Legal_Opciones  97030000, 1, 'MMMM', 0, 0, 0, 0 
        SP_Condiciones_Generales_Legal_Opciones  97030000, 1, 'MMMM', 0, 0, 0, 0 
        SP_Condiciones_Generales_Legal_Opciones  0, 1, 'MMMM', 0, 0, 0, 0 

Reporte                                  TipReg     CliRut          CliCod  CliDv CliNom                                                                                               FechaCG                     FechaCondGeneLarga             FechaCGDeriva


do             FechaCondGeneLargaDerivado     ApoderadoClienteRut01 ApoderadoClienteDv01 ApoderadoClienteNombre01                                                                             ApoderadoClienteDomicilio01                                      


                                    ApoderadoClienteFax01                              ApoderadoClienteFono01                             ApoderadoBancoRut01 ApoderadoBancoDv01 ApoderadoBancoNombre01                                                        


                       ApoderadoBancoDomicilio01                                                                            ApoderadoBancoFax01                                ApoderadoBancoFono01                               BancoNom                     


                                                                        BancoRut    BancoDv BancoDom                                                                                             BancoFono                                          BancoFax   


                                        BancoCodigo 
---------------------------------------- ---------- --------------- ------- ----- ---------------------------------------------------------------------------------------------------- --------------------------- ------------------------------ -------------


-------------- ------------------------------ --------------------- -------------------- ---------------------------------------------------------------------------------------------------- -----------------------------------------------------------------


----------------------------------- -------------------------------------------------- -------------------------------------------------- ------------------- ------------------ ------------------------------------------------------------------------------


---------------------- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -----------------------------


----------------------------------------------------------------------- ----------- ------- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- -----------


--------------------------------------- ----------- 
COND. GENERAL                            LEGAL      97030000        1       7     BANCOESTADO                                                                                          2007-11-09 00:00:00.000     9 Noviembre del año 2007       2007-11-09 00


:00:00.000     9 Noviembre del año 2007       9188181               0                    VICTOR MAGUIDA CAJAS                                                                                 ALAMEDA 1111                                                     


     9707556                                 6707383                                            8346589             1                  MARCELO CERDA VILCHES                                                                    
            ROSARIO NORTE # 660                                                                                  6602676                                            2222222                                            CORPBANCA                               


                                                             97023000    9       ROSARIO NORTE # 660                                                                                  2222222                                            6602676               


                             1
Reporte                                  TipReg     CliRut          CliCod  CliDv CliNom                                                                                               FechaCG                     FechaCondGeneLarga             FechaCGDeriva


do             FechaCondGeneLargaDerivado     ApoderadoClienteRut01 ApoderadoClienteDv01 ApoderadoClienteNombre01                                                                             ApoderadoClienteDomicilio01                                      


                                    ApoderadoClienteFax01                              ApoderadoClienteFono01                             ApoderadoBancoRut01 ApoderadoBancoDv01 ApoderadoBancoNombre01                                                        


                       ApoderadoBancoDomicilio01                                                                            ApoderadoBancoFax01                                ApoderadoBancoFono01                               BancoNom                     


                                                                        BancoRut    BancoDv BancoDom                                                                                             BancoFono                                          BancoFax   


                                        BancoCodigo 
---------------------------------------- ---------- --------------- ------- ----- ---------------------------------------------------------------------------------------------------- --------------------------- ------------------------------ -------------


-------------- ------------------------------ --------------------- -------------------- ---------------------------------------------------------------------------------------------------- -----------------------------------------------------------------


----------------------------------- -------------------------------------------------- -------------------------------------------------- ------------------- ------------------ ------------------------------------------------------------------------------


---------------------- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -----------------------------


----------------------------------------------------------------------- ----------- ------- ---------------------------------------------------------------------------------------------------- -------------------------------------------------- -----------


--------------------------------------- ----------- 
COND. GENERAL                            LEGAL      0               0             REGISTRO VACIO                                                                                       1900-01-01 00:00:00.000     12 de Diciembre del año 2009   1900-01-01 00


:00:00.000     12 de Diciembre del año 2009   0                     0                                                            0                                                                                                                             


              ROSARIO NORTE # 660                                                                                6602676                                            2222222                                            CORPBANCA                             
                                                               97023000    9       ROSARIO NORTE # 660                                                                                  2222222                                            6602676            



 
                               1


     */
     -- Idea: utilizar distinct y tablas verticales ( si existen )

     SET NOCOUNT ON			

     -- Pora hacer por elegancia: generalizar con @@DATEFIRST cualquiera
     set DATEFIRST 7


     Declare  @Nombre Char(120)
            , @Rut    Numeric(9)
            , @Dv     Char(1)
            , @FechaProceso datetime
            , @Domicilio VarChar( 50 )
            , @Fax       VarChar( 100 )
            , @Fono       VarChar(100)
            , @Codigo     Numeric( 2 )
            , @RutCliente numeric(9) 
            , @CodCliente numeric(2)
            , @DomicilCliente Varchar(100) 
            , @FaxCliente     Varchar(100)
            , @FonoCliente    VarChar(100)
            

     select  @FechaProceso = FechaProc
           , @Nombre       = nombre  
           , @Rut          = rut 
           , @Domicilio    = direccion
           , @Fono         = telefono
           , @Fax          = Fax            
           , @Codigo       = 1
           , @Dv           = Cli.ClDv
           from OpcionesGeneral , lnkBac.BacParamSuda.dbo.Cliente Cli
     where   Cli.ClRut = rut and Cli.ClCodigo = 1


     SELECT  TOP 2
             'RutRepBco' = aprutcli 
           , 'DvRepBco'  = apdvcli           
           , 'NomRepBco' = apnombre  
           , 'CodBco'    = apcodcli
           , 'NumReg'    = Identity(INT)   
     INTO  #RepBco
     FROM  lnkbac.bacparamsuda.dbo.Cliente_Apoderado
     WHERE aprutcli = @Rut 
     and   ApCodCli = @Codigo 



     SELECT  TOP 2
             'RutRepCli' = aprutcli 
           , 'DvRepCli'  = apdvcli           
           , 'NomRepCli' = apnombre  
           , 'CodCli'    = apcodcli
           , 'NumReg'    = Identity(INT)   
     INTO  #RepCli
     FROM  lnkbac.bacparamsuda.dbo.Cliente_Apoderado
     WHERE aprutcli = @CliRut 
     and   ApCodCli = @CliCodigo 


--   SELECT  *  FROM  lnkbac.bacparamsuda.dbo.Cliente_Apoderado

     -- Sección que genera el registro vacío.
      Select distinct
              'Reporte'        = convert( Varchar(40) , 'COND. GENERAL' )
            , 'TipReg'          = Convert( Varchar(10), 'LEGAL'  )
            , 'CliRut'  	= Convert( numeric(13) , 0 )
            , 'CliCod'          = convert( numeric(5)  , 0 )
            , 'CliDv'           = Convert( varchar(1)  , ''  )
            , 'CliNom'  	= Convert( varchar(100), 'REGISTRO VACIO' )
            , 'FechaCG'             = Convert( datetime    , '19000101' )
            , 'FechaCondGeneLarga'  = convert( VarChar(30), '12 de Diciembre del año 2009' )  

            , 'FechaCGDerivado'         = Convert( datetime , '19000101'  ) 
                                          
            , 'FechaCondGeneLargaDerivado'  = convert( VarChar(30), '12 de Diciembre del año 2009' ) 


            , 'ApoderadoClienteRut01'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoClienteDv01'          = Convert( Varchar(1)  , 0 )
            , 'ApoderadoClienteNombre01'      = Convert( Varchar(100), '' )
            , 'ApoderadoClienteDomicilio01'   = Convert( varchar(100), '' )
            , 'ApoderadoClienteFax01'         = Convert( varchar(50), '' ) 
            , 'ApoderadoClienteFono01'        = Convert( varchar(50), '' )

            , 'ApoderadoBancoRut01'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoBancoDv01'          = Convert( Varchar(1)  , '' )
            , 'ApoderadoBancoNombre01'      = Convert( Varchar(100), '' )

            , 'ApoderadoBancoDomicilio01'   = Convert( Varchar(100), @Domicilio )
            , 'ApoderadoBancoFax01'         = Convert( Varchar(50) , @Fax ) 
            , 'ApoderadoBancoFono01'        = Convert( VarChar(50) , @Fono )

/* por mientras uno de cada uno */
            , 'ApoderadoClienteRut02'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoClienteDv02'          = Convert( Varchar(1)  , 0 )
            , 'ApoderadoClienteNombre02'      = Convert( Varchar(100), '' )
            , 'ApoderadoClienteDomicilio02'   = Convert( Varchar(100), '' )  
            , 'ApoderadoClienteFax02'         = Convert( Varchar(50) , '' ) 


            , 'ApoderadoBancoRut02'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoBancoDv02'          = Convert( Varchar(1)  , '' )
            , 'ApoderadoBancoNombre02'      = Convert( Varchar(100), '' )
            , 'ApoderadoBancoDomicilio02'   = Convert( Varchar(100), '' )
            , 'ApoderadoBancoFax02'         = Convert( Varchar(50) , '' )  

	   , 'BancoNom'         = convert( varchar(100), @nombre  )
           , 'BancoRut'         = Convert( numeric(9), @rut )
           , 'BancoDv'          = Convert( varchar(1), @dv )
           , 'BancoDom'         = convert( varchar(100), @Domicilio  )  
           , 'BancoFono'        = convert( varchar(50), @Fono )        
           , 'BancoFax'         = convert( varchar(50), @Fax  )                    
           , 'BancoCodigo'      = convert( numeric(2)  , @Codigo )
            INTO #Resultado -- Genera tabla con el registro vacío


      Select distinct
              'Reporte'        = convert( Varchar(40) , 'COND. GENERAL' )
            , 'TipReg'          = Convert( Varchar(10), 'LEGAL'  )
            , 'CliRut'  	= Convert( numeric(13) , Cliente.ClRut )
            , 'CliCod'          = convert( numeric(5)  , Cliente.ClCodigo )
            , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, '' )   )
            , 'CliNom'  	= Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no esta en BAC' ) )
            , 'FechaCG'         = Convert( datetime    , isnull( ( select clFechaFirma_cond_Opc 
                                                                     from breakBacParamSudaCliente BC
                                                                      where Bc.ClRut = Cliente.ClRut 
                                                                        and Bc.ClCodigo = Cliente.ClCodigo )  
                                                                     , Cliente.clFechaFirma_cond  ) 
                                          )
            , 'FechaCondGeneLarga'  = convert( VarChar(30), '12 de Diciembre del año 2009' )  

            , 'FechaCGDerivado'         = Convert( datetime , Cliente.clFechaFirma_cond  ) 
                                          
            , 'FechaCondGeneLargaDerivado'  = convert( VarChar(30), '12 de Diciembre del año 2009' ) 



            , 'ApoderadoClienteRut01'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoClienteDv01'          = Convert( Varchar(1)  , 0 )
            , 'ApoderadoClienteNombre01'      = Convert( Varchar(100), '' )
            , 'ApoderadoClienteDomicilio01'   = Convert( Varchar(100), Cldirecc  )
            , 'ApoderadoClienteFax01'         = Convert( VarChar(50) , Clfax ) 
            , 'ApoderadoClienteFono01'        = Convert( Varchar(50) , Clfono )

            , 'ApoderadoBancoRut01'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoBancoDv01'          = Convert( Varchar(1)  , '' )
            , 'ApoderadoBancoNombre01'      = Convert( Varchar(100), '' )

            , 'ApoderadoBancoDomicilio01'   = Convert( Varchar(100), @Domicilio )
            , 'ApoderadoBancoFax01'         = Convert( Varchar(50) , @Fax ) 
            , 'ApoderadoBancoFono01'        = Convert( VarChar(50) , @Fono )

/* por mientras uno de cada uno */
            , 'ApoderadoClienteRut02'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoClienteDv02'          = Convert( Varchar(1)  , 0 )
            , 'ApoderadoClienteNombre02'      = Convert( Varchar(100), '' )
            , 'ApoderadoClienteDomicilio02'   = Convert( Varchar(100), '' )  
            , 'ApoderadoClienteFax02'         = Convert( Varchar(50) , '' ) 


            , 'ApoderadoBancoRut02'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoBancoDv02'          = Convert( Varchar(1)  , '' )
            , 'ApoderadoBancoNombre02'      = Convert( Varchar(100), '' )
            , 'ApoderadoBancoDomicilio02'   = Convert( Varchar(100), '' )
            , 'ApoderadoBancoFax02'         = Convert( Varchar(50) , '' )  

	   , 'BancoNom'         = convert( varchar(100), @nombre  )
           , 'BancoRut'         = Convert( numeric(9), @rut )
           , 'BancoDv'          = Convert( varchar(1), @dv )
           , 'BancoDom'         = convert( varchar(100), @Domicilio  )  
           , 'BancoFono'        = convert( varchar(50), @Fono )        
           , 'BancoFax'         = convert( varchar(50), @Fax  )                    
           , 'BancoCodigo'      = convert( numeric(2)  , @Codigo )
            


      into #Cliente
      from LnkBac.BacParamSuda.dbo.Cliente   Cliente
         where Cliente.ClRut = @CliRut 
           and Cliente.ClCodigo = @CliCodigo 

      IF exists( select (1) from #Cliente  ) BEGIN
          update #Cliente 
              set  FechaCondGeneLarga = convert( varchar(2), day( FechaCG ) )  +
                                      Case when month( FechaCG ) = 1 then ' Enero '
                                           when month( FechaCG ) = 2 then ' Febrero '
                                           when month( FechaCG ) = 3 then ' Marzo '
                                           when month( FechaCG ) = 4 then ' Abril '     
                                           when month( FechaCG ) = 5 then ' Mayo '  
                                           when month( FechaCG ) = 6 then ' Junio '
                                           when month( FechaCG ) = 7 then ' Julio ' 
                                           when month( FechaCG ) = 8 then ' Agosto ' 
                                           when month( FechaCG ) = 9 then ' Septiembre ' 
                                           when month( FechaCG ) = 10 then ' Octubre '  
                                           when month( FechaCG ) = 11 then ' Noviembre ' 
                                           when month( FechaCG ) = 12 then ' Diciembre ' End +
                                       'del año ' + convert( varchar(4) , year( FechaCG ) ) 

            , FechaCondGeneLargaDerivado  = convert( varchar(2), day( FechaCGDerivado ) )  +
                                      Case when month( FechaCGDerivado ) = 1 then ' Enero '
                                           when month( FechaCGDerivado ) = 2 then ' Febrero '
                                           when month( FechaCGDerivado ) = 3 then ' Marzo '
                                           when month( FechaCGDerivado ) = 4 then ' Abril '     
                                           when month( FechaCGDerivado ) = 5 then ' Mayo '  
                                           when month( FechaCGDerivado ) = 6 then ' Junio '
                                           when month( FechaCGDerivado ) = 7 then ' Julio ' 
                                           when month( FechaCGDerivado ) = 8 then ' Agosto ' 
                                           when month( FechaCGDerivado ) = 9 then ' Septiembre ' 
                                           when month( FechaCGDerivado ) = 10 then ' Octubre '  
                                           when month( FechaCGDerivado ) = 11 then ' Noviembre ' 
                                           when month( FechaCGDerivado ) = 12 then ' Diciembre ' End +
                                       'del año ' + convert( varchar(4) , year( FechaCGDerivado ) ) 


              , ApoderadoClienteRut01         = Convert( numeric(9), isnull( ( select RutRepCli from #RepCli
                                                                               where NumReg   = 1 )
                                                                               -- and ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 ) 
                                                                            , 0 ) )
              , ApoderadoClienteDv01          = Convert( Varchar(1)  , isnull( ( select DvRepCli from #RepCli
                                                                               where NumReg   = 1 )
                                                                               -- and ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 ) 
                                                                            , 0 ) ) 
              , ApoderadoClienteNombre01      = Convert( Varchar(100), isnull( ( select NomRepCli from #RepCli
                                                                               where NumReg   = 1 )
                                                                                -- and ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 ) 
                                                                            , 'No hay apoderados definidos' ) )
/*
              , ApoderadoClienteDomicilio01   = Convert( Varchar(100), @DomicilCliente )
              , ApoderadoClienteFax01         = Convert( Varchar(50) , @FaxCliente ) 
              , ApoderadoClienteFono01        = Convert( VarChar(50) , @FonoCliente )
*/

              , ApoderadoClienteRut02         = Convert( numeric(9), isnull( ( select RutRepCli  from #RepCli
                                                                              where NumReg   = 2 )
                                                                                -- and ( aprutapo = @RutRepCli02 or @RutRepCli01 = 0 ) 
                                                                            , 0 ) )
              , ApoderadoClienteDv02          = Convert( Varchar(1)  , isnull( ( select  DvRepCli  from #RepCli
                                                                              where NumReg   = 2 )
                                                                                -- and ( aprutapo = @RutRepCli02 or @RutRepCli01 = 0 ) 
                                                                            , 0 ) ) 
              , ApoderadoClienteNombre02      = Convert( Varchar(100), isnull( ( select NomRepCli  from #RepCli
                                                                              where NumReg   = 2 )
                                                                                -- and ( aprutapo = @RutRepCli02 or @RutRepCli01 = 0 ) 
                                                                            , 'No hay apoderados definidos' ) )
              , ApoderadoBancoRut01         = Convert( numeric(9)  , isnull( ( select RutRepBco from #RepBco
                                                                              where NumReg   = 1 )
                                                                                -- and ( aprutapo = @RutRepBan01 or @RutRepBan01 = 0 ) 
                                                                            , 0 ) )
              , ApoderadoBancoDv01          = Convert( Varchar(1)  , isnull( ( select DvRepBco  from #RepBco
                                                                              where NumReg   = 1 )
                                                                                -- and ( aprutapo = @RutRepBan01 or @RutRepBan01 = 0 ) 
                                                                            , 0 ) )
              , ApoderadoBancoNombre01      = Convert( Varchar(100), isnull( ( select NomRepBco  from #RepBco
                                                                              where NumReg   = 1 )
                                                                                -- and ( aprutapo = @RutRepBan01 or @RutRepBan01 = 0 ) 
                                                                            , 'No hay apoderados definidos'  ) )
              , ApoderadoBancoRut02         = Convert( numeric(9)  , isnull( ( select  RutRepBco  from #RepBco
                                                                              where NumReg   = 2 )
                                                                                -- and ( aprutapo = @RutRepBan02 or @RutRepBan01 = 0 ) 
                                                                            , 0 ) )
              , ApoderadoBancoDv02          = Convert( Varchar(1)  , isnull( ( select  DvRepBco  from #RepBco
                                                                              where NumReg   = 2 )
                                                                                -- and ( aprutapo = @RutRepBan02 or @RutRepBan01 = 0 ) 
                                                                            , 0 ) )
              , ApoderadoBancoNombre02      = Convert( Varchar(100), isnull( ( select NomRepBco  from #RepBco
                                                                              where NumReg   = 2 )
                                                                                -- and ( aprutapo = @RutRepBan02 or @RutRepBan01 = 0 ) 
                                                                            , 'No hay apoderados definidos'  ) )

 
         select * from #Cliente     
      END
      ELSE
         -- Se despliega el registro Sin Datos.
         select * from   #Resultado        		   

END

GO
