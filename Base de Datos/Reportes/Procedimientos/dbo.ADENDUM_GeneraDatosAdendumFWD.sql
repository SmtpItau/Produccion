USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ADENDUM_GeneraDatosAdendumFWD]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ADENDUM_GeneraDatosAdendumFWD]
      (     @nContrato  numeric(9)  
      ,     @cEstado    varchar(25)  
      ,     @dFecha           varchar(10)  
      ,     @cHora            char(8)  
			, @RutApoderado1 numeric(10)  
			, @RutApoderado2 numeric(10)   
			, @RUTAPODERADOCLI1 numeric(10)  
			, @RUTAPODERADOCLI2  numeric(10)  
      )  
as  
begin  

DECLARE @cNom_Apoderado_Cliente_1	VARCHAR(40)
DECLARE @cRut_Apoderado_Cliente_1	VARCHAR(40)
DECLARE @cNom_Apoderado_Cliente_2	VARCHAR(40)
DECLARE @cRut_Apoderado_Cliente_2	VARCHAR(40)

SET @cNom_Apoderado_Cliente_1 = (select DISTINCT(apnombre) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo = @RUTAPODERADOCLI1) 

SET @cRut_Apoderado_Cliente_1 = (select LTRIM(RTRIM(aprutcli)) + '-' + LTRIM(RTRIM(apdvcli)) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo =  @RUTAPODERADOCLI1) 

SET @cNom_Apoderado_Cliente_2 = (select DISTINCT(apnombre) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo = @RUTAPODERADOCLI2) 

SET @cRut_Apoderado_Cliente_2 = (select LTRIM(RTRIM(aprutcli)) + '-' + LTRIM(RTRIM(apdvcli)) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo =  @RUTAPODERADOCLI2) 

	
  
--Sp_Genera_Adendum_Forward 34419, 'Modificada',  '20130625', '15:59:38'  
--Sp_Genera_Adendum_Forward 556693, 'Modificada', '20130410', '14:11:44'  
  
 --select cacodpos1, * from Mfca_Log where canumoper = 556693  
 --select cacodpos1, * from Mfca  where canumoper = 556693  
 -- select * from BacParamSuda.dbo.producto where id_sistema = 'bfw' and codigo_producto = 1  
 --select cacodpos1, * from MfcaRES where canumoper = 556693  
  
--declare @cEstado    varchar(25)  
--declare @nContrato  numeric(9)  
--declare @dFecha     datetime  
--declare @cHora      char(8)  
--declare @RutApoderado1 numeric(10)  
--declare @RutApoderado2 numeric(10)   
  
--set @cEstado = 'Modificada'  
--set @nContrato = 556693  
--set @dFecha = '20130410'  
--set @cHora = '14:11:44'  
--set @RutApoderado1 = 13842499  
--set @RutApoderado2 = 13671071  
  
--set @cEstado = 'Anticipo'  
--set @nContrato = 554557  
--set @dFecha = '20120912'  
--set @cHora = ''  
  
--select convert(char(10),getdate(),105)  
--select convert(char(10),'2012-01-09',105)  
  
  
--select * from MfcaRes where canumoper = 45611 and cafecmod = '2012-01-09'  
--select * from MfcaRes where canumoper = 45611 and convert(char(10),cafecmod,105) = '09-01-2012'  
  
  
  
      set nocount on  
  
      if @cEstado = 'Anticipo'  
      begin  
            select      Folio                   = Original.canumoper  
            ,           Fecha_Adendum          -- = Original.cafecvcto  
              
           = (select  convert(char(2), Original.cafecvcto, 103) + ' de '  
           +     case  when datepart( month, Original.cafecvcto) = 1  then 'Enero'  
            when datepart( month, Original.cafecvcto) = 2  then 'Febrero'  
            when datepart( month, Original.cafecvcto) = 3  then 'Marzo'  
            when datepart( month, Original.cafecvcto) = 4  then 'Abril'  
            when datepart( month, Original.cafecvcto) = 5  then 'Mayo'  
            when datepart( month, Original.cafecvcto) = 6  then 'Junio'  
            when datepart( month, Original.cafecvcto) = 7  then 'Julio'  
            when datepart( month, Original.cafecvcto) = 8  then 'Agosto'  
            when datepart( month, Original.cafecvcto) = 9  then 'Septiembre'  
            when datepart( month, Original.cafecvcto) = 10 then 'Octubre'  
            when datepart( month, Original.cafecvcto) = 11 then 'Noviembre'  
            when datepart( month, Original.cafecvcto) = 12 then 'Diciembre'  
               end + ' de '   
            +     ltrim(rtrim( datepart(year, Original.cafecvcto) )))  
              
              
              
              
              
              
            ,    Hora_Adendum            = Original.cahora  
            ,           Fecha_Adendum_Anterior  = case when Adendum.FechaAdendum is null then '' else convert(char(10), Adendum.FechaAdendum, 103 ) end   
            ---------------------------------  
            ,           Orig_Fecha_Cierre       --= Original.cafecha  
            = (select  convert(char(2), Original.cafecha, 103) + ' de '  
             +     case  when datepart( month, Original.cafecha) = 1  then 'Enero'  
              when datepart( month, Original.cafecha) = 2  then 'Febrero'  
              when datepart( month, Original.cafecha) = 3  then 'Marzo'  
              when datepart( month, Original.cafecha) = 4  then 'Abril'  
              when datepart( month, Original.cafecha) = 5  then 'Mayo'  
              when datepart( month, Original.cafecha) = 6  then 'Junio'  
              when datepart( month, Original.cafecha) = 7  then 'Julio'  
         when datepart( month, Original.cafecha) = 8  then 'Agosto'  
              when datepart( month, Original.cafecha) = 9  then 'Septiembre'  
              when datepart( month, Original.cafecha) = 10 then 'Octubre'  
              when datepart( month, Original.cafecha) = 11 then 'Noviembre'  
              when datepart( month, Original.cafecha) = 12 then 'Diciembre'  
                 end + ' de '   
              +     ltrim(rtrim( datepart(year, Original.cafecha) )))  
                
              
              
              
            ,           Orig_Rut_Cliente        = ltrim(rtrim( Cliente.clrut )) + '-' + ltrim(rtrim( Cliente.cldv ))  
            ,           Orig_Nombre_Cliente     = Cliente.clnombre  
            ,           Orig_Comprador          = case when Original.catipoper = 'C' then 'CORPBANCA'        ELSE Cliente.clnombre   END  
            ,           Orig_Vendedor           = case when Original.catipoper = 'C' then Cliente.clnombre   ELSE 'CORPBANCA'        END  
            ,           Orig_Tipo_Operacion     = case when Original.catipoper = 'C' then 'Compra'                else 'Venta'                 end   
            ,           Orig_Modalidad          = case when Original.catipmoda = 'C' then 'Compensación'     else 'Entrega Fisica'   end   
            ,           Orig_Moneda             = Moneda.mnnemo  
            ,           Orig_Moneda_Glosa       = Moneda.mnglosa  
            ,           Orig_Monto              = Original.camtomon1  
            ,           Orig_TipoCambio         = Original.catipcam  
            ,           Orig_MonedaCnv          = MonCnv.mnnemo  
            ,           Orig_MonedaCnv_Glosa    = MonCnv.mnglosa  
            ,           Orig_MontoCnv           = Original.camtomon2  
            ,           Orig_Fecha_Venciminto   = Original.cafecvcto  
            ,           Orig_MonedaReferencial  = MonRef.mnglosa  
            ---------------------------------  
            ,           Modi_Fecha_Cierre       = Modificada.Modi_Fecha_Cierre  
            ,           Modi_Rut_Cliente        = Modificada.Modi_Rut_Cliente  
            ,           Modi_Nombre_Cliente     = Modificada.Modi_Nombre_Cliente  
            ,           Modi_Comprador          = Modificada.Modi_Comprador  
            ,           Modi_Vendedor           = Modificada.Modi_Vendedor  
            ,           Modi_Tipo_Operacion     = Modificada.Modi_Tipo_Operacion  
            ,           Modi_Modalidad          = Modificada.Modi_Modalidad  
            ,           Modi_Moneda             = Modificada.Modi_Moneda  
            ,           Modi_Moneda_Glosa       = Modificada.Modi_Moneda_Glosa  
            ,           Modi_Monto              = Modificada.Modi_Monto  
            ,           Modi_TipoCambio         = Modificada.Modi_TipoCambio  
            ,           Modi_MonedaCnv          = Modificada.Modi_MonedaCnv  
            ,           Modi_MonedaCnv_Glosa    = Modificada.Modi_MonedaCnv_Glosa  
            , Modi_MontoCnv           = Modificada.Modi_MontoCnv  
            ,           Modi_Fecha_Venciminto   = Modificada.Modi_Fecha_Venciminto  
            ,           Modi_MonedaReferencial  = Modificada.Modi_MonedaReferencial  
            ----------------------------------  
   ,   Titulo_Adendum   = 'DE COMPRAVENTA Y DE ARBITRAJE FUTURO DE MONEDA EXTRANJERA'  
     
   ,   'Domicilio_Cliente'  = Modi_Domicilio_Cli  
   ,   'Fono_Cliente'   = Modi_Fono_Cli  
   ,   'Fax_Cliente'   = Modi_Fax_Cli  
     
   ,   'Nombre_Apoderado_uno' = apoderado1.apnombre  
   ,   'Rut_Apoderado_Uno'  = rtrim(ltrim(convert(char(10),apoderado1.aprutapo))) + '-' + apoderado1.apdvapo  
   ,   'Apoderado_Dos'   =   apoderado2.apnombre  
   ,   'Rut_Apoderado_Dos'  = rtrim(ltrim(convert(char(10),apoderado2.aprutapo))) + '-' + apoderado2.apdvapo 
  
   ,	'Nombre_Apoderado_Cli_uno' = @cNom_Apoderado_Cliente_1 
   ,  'Rut_Apoderado_Cli_Uno' = @cRut_Apoderado_Cliente_1
    ,	'Nombre_Apoderado_Cli_dos' = @cNom_Apoderado_Cliente_2
   ,  'Rut_Apoderado_Cli_dos' = @cRut_Apoderado_Cliente_2

   , 'Fecha_Firma_CCG'	= dbo.Fx_Retorna_Mes( Cliente.FECHA_FIRMA_NUEVO_CCG )			--Cliente.FECHA_FIRMA_NUEVO_CCG

     
            from  BacFwdSuda.dbo.MfcaRes  Original    with(nolock)  
                   inner join BacParamSuda.dbo.Cliente Cliente    with(nolock) On      Cliente.clrut           = Original.cacodigo   
                                                                                                                and Cliente.clcodigo    = Original.cacodcli  
                        inner join BacParamSuda.dbo.Moneda Moneda      with(nolock) On      Moneda.mncodmon         = Original.cacodmon1  
                        inner join BacParamSuda.dbo.Moneda MonCnv      with(nolock) On      MonCnv.mncodmon         = Original.cacodmon2  
                        inner join BacParamSuda.dbo.Moneda MonRef      with(nolock) On      MonRef.mncodmon         = Original.camdausd  
  
      inner join bacparamsuda.dbo.CLIENTE_APODERADO apoderado1 with(nolock) On apoderado1.aprutapo = @RutApoderado1  
      inner join bacparamsuda.dbo.CLIENTE_APODERADO apoderado2 with(nolock) On apoderado2.aprutapo = @RutApoderado2  
  
                        inner join (        
                                               select      Modi_Contrato                = Modificacda.canumoper  
                                               ,           Modi_Fecha_Cierre       = Modificacda.cafecha  
                                               ,           Modi_Rut_Cliente        = ltrim(rtrim( Cliente.clrut )) + '-' + ltrim(rtrim( Cliente.cldv ))  
                                               ,           Modi_Nombre_Cliente          = Cliente.clnombre  
                                               ,           Modi_Comprador               = case when Modificacda.catipoper = 'C' then 'CORPBANCA'           ELSE Cliente.clnombre   END  
                                               ,           Modi_Vendedor                = case when Modificacda.catipoper = 'C' then Cliente.clnombre      ELSE 'CORPBANCA'        END  
                                               ,           Modi_Tipo_Operacion          = case when Modificacda.catipoper = 'C' then 'Compra'              else 'Venta'                  end   
                                               ,           Modi_Modalidad               = case when Modificacda.catipmoda = 'C' then 'Compensación'        else 'Entrega Fisica'   end   
                                               ,           Modi_Moneda                  = Moneda.mnnemo  
                                               ,           Modi_Moneda_Glosa       = Moneda.mnglosa  
                                               ,           Modi_Monto                   = Modificacda.camtomon1  
                                               ,           Modi_TipoCambio              = Modificacda.catipcam  
												,           Modi_MonedaCnv               = MonCnv.mnnemo  
                                               ,           Modi_MonedaCnv_Glosa    = MonCnv.mnglosa  
                                               ,           Modi_MontoCnv                = Modificacda.camtomon2  
                                               ,           Modi_Fecha_Venciminto   = Modificacda.cafecvcto  
                                               ,           Modi_MonedaReferencial  = MonRef.mnglosa  
                                                 
                                               ,      Modi_Domicilio_Cli  = Cliente.Cldirecc  
                                               ,     Modi_Fono_Cli   = Cliente.Clfono  
                                               ,     Modi_Fax_Cli   = Cliente.Clfax  
                                                 
                                               from  BacFwdSuda.dbo.Mfca          Modificacda      with(nolock)  
                                                           inner join BacParamSuda.dbo.Cliente Cliente   with(nolock) On  Cliente.clrut           = Modificacda.cacodigo   
                 and Cliente.clcodigo    = Modificacda.cacodcli  
          inner join BacParamSuda.dbo.Moneda      Moneda      with(nolock) On  Moneda.mncodmon         = Modificacda.cacodmon1  
                           inner join BacParamSuda.dbo.Moneda      MonCnv      with(nolock) On  MonCnv.mncodmon         = Modificacda.cacodmon2  
                                                           inner join BacParamSuda.dbo.Moneda      MonRef      with(nolock) On  MonRef.mncodmon         = Modificacda.camdausd  
                                               where Modificacda.canumoper   = @nContrato  
                                               and         Modificacda.caantici         = 'A'  
                                               and         Modificacda.caestado         = ''  
                                                     union  
                                               select  Modi_Contrato                = Modificacda.canumoper  
                                               ,   Modi_Fecha_Cierre    = Modificacda.cafecha  
                                               ,   Modi_Rut_Cliente    = ltrim(rtrim( Cliente.clrut )) + '-' + ltrim(rtrim( Cliente.cldv ))  
                                               ,   Modi_Nombre_Cliente          = Cliente.clnombre  
                                               ,   Modi_Comprador               = case when Modificacda.catipoper = 'C' then 'CORPBANCA'           ELSE Cliente.clnombre   END  
                                               ,   Modi_Vendedor                = case when Modificacda.catipoper = 'C' then Cliente.clnombre      ELSE 'CORPBANCA'        END  
                                               ,   Modi_Tipo_Operacion          = case when Modificacda.catipoper = 'C' then 'Compra'              else 'Venta'                  end   
                                               ,   Modi_Modalidad               = case when Modificacda.catipmoda = 'C' then 'Compensación'        else 'Entrega Fisica'   end   
                                               ,   Modi_Moneda                  = Moneda.mnnemo  
                                               ,   Modi_Moneda_Glosa    = Moneda.mnglosa  
                                               ,   Modi_Monto                   = Modificacda.camtomon1  
                                               ,   Modi_TipoCambio              = Modificacda.catipcam  
                                               ,   Modi_MonedaCnv               = MonCnv.mnnemo  
                                               ,   Modi_MonedaCnv_Glosa   = MonCnv.mnglosa  
                                               ,   Modi_MontoCnv                = Modificacda.camtomon2  
                                               ,   Modi_Fecha_Venciminto   = Modificacda.cafecvcto  
                                 ,   Modi_MonedaReferencial   = MonRef.mnglosa  
                                                 
                                               ,   Modi_Domicilio     = Cliente.Cldirecc  
                                               ,   Modi_Fono_Cli     = Cliente.Clfono  
                                               ,   Modi_Fax_Cli     = Cliente.Clfax  
                                                 
                                               from   BacFwdSuda.dbo.MfcaH    Modificacda with(nolock)  
               inner join BacParamSuda.dbo.Cliente Cliente   with(nolock) On  Cliente.clrut           = Modificacda.cacodigo   
                                                                                                                                                   and Cliente.clcodigo    = Modificacda.cacodcli  
               inner join BacParamSuda.dbo.Moneda      Moneda      with(nolock) On  Moneda.mncodmon         = Modificacda.cacodmon1  
               inner join BacParamSuda.dbo.Moneda      MonCnv      with(nolock) On  MonCnv.mncodmon    = Modificacda.cacodmon2  
               inner join BacParamSuda.dbo.Moneda MonRef      with(nolock) On  MonRef.mncodmon         = Modificacda.camdausd  
                                               where  Modificacda.canumoper   = @nContrato  
                    and   Modificacda.caantici    = 'A'  
                                               and   Modificacda.caestado    = ''  
                                         )     Modificada  On    Modificada.Modi_Contrato      = Original.canumoper  
  


                        --left  join  (     select      Folio             = Original.canumoper  
                        --                       ,           FechaAdendum      = MAX(Original.cafecmod)  
                        --                       from  BacFwdSuda.dbo.Mfca_log Original  
                        --                       where canumoper         = @nContrato  
                        --                       and         caestado          = 'M'  
                        --                       and         convert(char(10),cafecmod,105)          < @dFecha  
                        --                       group   
                        --                       by          Original.canumoper  
                        --                 )     Adendum     On Adendum.Folio  = Original.canumoper  


						left join		( select 
												 FechaAdendum = datos.cafecmod
												
												from 
												(select 
												 ROW_NUMBER() OVER(ORDER BY cafecmod DESC) AS id
												,cafecmod
												,canumoper
												from  BacFwdSuda.dbo.Mfca_log with(nolock)  
																		where canumoper         = @nContrato 
																		 and   caestado    <> 'A'   
																					and caantici  <> 'A'  ) as datos
												where datos.id = 2)  Adendum on Adendum.FechaAdendum <> ''


              
            where Original.cafechaproceso = (select acfecante from BacFwdSuda.dbo.mfach with(nolock) where convert(char(10),acfecproc,105) = @dFecha)  
            and         Original.canumoper           = @nContrato  
      end  
  
  
      if @cEstado = 'Modificada'  
      begin  
            select      top 1  
                        Folio                   = Original.canumoper  
            ,           Fecha_Adendum       --  = Original.cafecmod  
            = (select  convert(char(2), Original.cafecmod, 103) + ' de '  
            +     case  when datepart( month, Original.cafecmod) = 1  then 'Enero'  
             when datepart( month, Original.cafecmod) = 2  then 'Febrero'  
             when datepart( month, Original.cafecmod) = 3  then 'Marzo'  
             when datepart( month, Original.cafecmod) = 4  then 'Abril'  
             when datepart( month, Original.cafecmod) = 5  then 'Mayo'  
             when datepart( month, Original.cafecmod) = 6  then 'Junio'  
             when datepart( month, Original.cafecmod) = 7  then 'Julio'  
             when datepart( month, Original.cafecmod) = 8  then 'Agosto'  
             when datepart( month, Original.cafecmod) = 9  then 'Septiembre'  
             when datepart( month, Original.cafecmod) = 10 then 'Octubre'  
             when datepart( month, Original.cafecmod) = 11 then 'Noviembre'  
             when datepart( month, Original.cafecmod) = 12 then 'Diciembre'  
                end + ' de '   
             +     ltrim(rtrim( datepart(year, Original.cafecmod) )))  
              
              
            ,           Hora_Adendum            = Original.cahora  
            ,           Fecha_Adendum_Anterior  = case when Adendum.FechaAdendum is null then '' else convert(char(10), Adendum.FechaAdendum, 103 ) end   
            ---------------------------------  
            ,           Orig_Fecha_Cierre       --= Original.cafecha  
            = (select  convert(char(2), Original.cafecha, 103) + ' de '  
            +     case  when datepart( month, Original.cafecha) = 1  then 'Enero'  
             when datepart( month, Original.cafecha) = 2  then 'Febrero'  
             when datepart( month, Original.cafecha) = 3  then 'Marzo'  
             when datepart( month, Original.cafecha) = 4  then 'Abril'  
             when datepart( month, Original.cafecha) = 5  then 'Mayo'  
             when datepart( month, Original.cafecha) = 6  then 'Junio'  
             when datepart( month, Original.cafecha) = 7  then 'Julio'  
             when datepart( month, Original.cafecha) = 8  then 'Agosto'  
             when datepart( month, Original.cafecha) = 9  then 'Septiembre'  
when datepart( month, Original.cafecha) = 10 then 'Octubre'  
             when datepart( month, Original.cafecha) = 11 then 'Noviembre'  
             when datepart( month, Original.cafecha) = 12 then 'Diciembre'  
                end + ' de '   
             +     ltrim(rtrim( datepart(year, Original.cafecha) )))  
              
            ,           Orig_Rut_Cliente        = ltrim(rtrim( Cliente.clrut )) + '-' + ltrim(rtrim( Cliente.cldv ))  
            ,           Orig_Nombre_Cliente     = Cliente.clnombre  
            ,           Orig_Comprador          = case when Original.catipoper = 'C' then 'CORPBANCA'        ELSE Cliente.clnombre   END  
            ,           Orig_Vendedor           = case when Original.catipoper = 'C' then Cliente.clnombre   ELSE 'CORPBANCA'        END  
            ,           Orig_Tipo_Operacion     = case when Original.catipoper = 'C' then 'Compra'                else 'Venta'                  end   
            ,           Orig_Modalidad          = case when Original.catipmoda = 'C' then 'Compensación'     else 'Entrega Fisica'   end   
            ,           Orig_Moneda             = Moneda.mnnemo  
            ,           Orig_Moneda_Glosa       = Moneda.mnglosa  
            ,           Orig_Monto              = Original.camtomon1  
            ,           Orig_TipoCambio         = Original.catipcam  
            ,           Orig_MonedaCnv          = MonCnv.mnnemo  
            ,           Orig_MonedaCnv_Glosa    = MonCnv.mnglosa  
            ,           Orig_MontoCnv           = Original.camtomon2  
            ,           Orig_Fecha_Venciminto   = Original.cafecvcto  
            ,           Orig_MonedaReferencial  = MonRef.mnglosa  
              
              
            ----------------------------------  
            ,           Modi_Fecha_Cierre       = Modificada.Modi_Fecha_Cierre  
            ,           Modi_Rut_Cliente        = Modificada.Modi_Rut_Cliente  
            ,           Modi_Nombre_Cliente     = Modificada.Modi_Nombre_Cliente  
            ,           Modi_Comprador          = Modificada.Modi_Comprador  
            ,           Modi_Vendedor           = Modificada.Modi_Vendedor  
            ,           Modi_Tipo_Operacion     = Modificada.Modi_Tipo_Operacion  
            ,           Modi_Modalidad          = Modificada.Modi_Modalidad  
            ,           Modi_Moneda             = Modificada.Modi_Moneda  
            ,           Modi_Moneda_Glosa       = Modificada.Modi_Moneda_Glosa  
            ,           Modi_Monto              = Modificada.Modi_Monto  
            ,           Modi_TipoCambio         = Modificada.Modi_TipoCambio  
            ,           Modi_MonedaCnv          = Modificada.Modi_MonedaCnv  
       ,           Modi_MonedaCnv_Glosa    = Modificada.Modi_MonedaCnv_Glosa  
            ,           Modi_MontoCnv           = Modificada.Modi_MontoCnv  
            ,           Modi_Fecha_Venciminto   = Modificada.Modi_Fecha_Venciminto  
            ,           Modi_MonedaReferencial  = Modificada.Modi_MonedaReferencial  
            ----------------------------------  
   ,   Titulo_Adendum   = 'DE COMPRAVENTA Y DE ARBITRAJE FUTURO DE MONEDA EXTRANJERA'  
     
   ,   'Domicilio_Cliente'  = Modi_Domicilio_Cli  
   ,   'Fono_Cliente'   = Modi_Fono_Cli  
   ,   'Fax_Cliente'   = Modi_Fax_Cli  
     
   ,   'Nombre_Apoderado_uno' = apoderado1.apnombre  
   ,   'Rut_Apoderado_Uno'  = rtrim(ltrim(convert(char(10),apoderado1.aprutapo))) + '-' + apoderado1.apdvapo  
   ,   'Apoderado_Dos'   =   apoderado2.apnombre  
   ,   'Rut_Apoderado_Dos'  = rtrim(ltrim(convert(char(10),apoderado2.aprutapo))) + '-' + apoderado2.apdvapo  
  

     ,	'Nombre_Apoderado_Cli_uno' = @cNom_Apoderado_Cliente_1 
   ,  'Rut_Apoderado_Cli_Uno' = @cRut_Apoderado_Cliente_1
    ,	'Nombre_Apoderado_Cli_dos' = @cNom_Apoderado_Cliente_2
   ,  'Rut_Apoderado_Cli_dos' = @cRut_Apoderado_Cliente_2

    , 'Fecha_Firma_CCG'	= dbo.Fx_Retorna_Mes( Cliente.FECHA_FIRMA_NUEVO_CCG )	




            from  BacFwdSuda.dbo.Mfca_Log                  Original with(nolock)  
                        inner join BacParamSuda.dbo.Cliente Cliente    with(nolock) On      Cliente.clrut           = Original.cacodigo   
                                                                         and Cliente.clcodigo    = Original.cacodcli  
                        inner join BacParamSuda.dbo.Moneda Moneda      with(nolock) On      Moneda.mncodmon         = Original.cacodmon1  
                        inner join BacParamSuda.dbo.Moneda MonCnv      with(nolock) On      MonCnv.mncodmon         = Original.cacodmon2  
                        inner join BacParamSuda.dbo.Moneda MonRef      with(nolock) On   MonRef.mncodmon         = Original.camdausd  
        
						inner join bacparamsuda.dbo.CLIENTE_APODERADO apoderado1 with(nolock) On apoderado1.aprutapo = @RutApoderado1  
						inner join bacparamsuda.dbo.CLIENTE_APODERADO apoderado2 with(nolock) On apoderado2.aprutapo = @RutApoderado2  
        
                        inner join (      select            Modi_Contrato      = Modificacda.canumoper  
                                                     ,           Modi_Fecha_Cierre    = Modificacda.cafecha  
                                                     ,           Modi_Rut_Cliente    = ltrim(rtrim( Cliente.clrut )) + '-' + ltrim(rtrim( Cliente.cldv ))  
                                                     ,           Modi_Nombre_Cliente   = Cliente.clnombre  
                                                     ,           Modi_Comprador     = case when Modificacda.catipoper = 'C' then 'CORPBANCA'         ELSE Cliente.clnombre      END  
                                                     ,           Modi_Vendedor     = case when Modificacda.catipoper = 'C' then Cliente.clnombre    ELSE 'CORPBANCA'        END  
                                                     ,           Modi_Tipo_Operacion   = case when Modificacda.catipoper = 'C' then 'Compra'                  else 'Venta'                  end   
                                                     ,           Modi_Modalidad     = case when Modificacda.catipmoda = 'C' then 'Compensación'            else 'Entrega Fisica'     end   
                                                     ,           Modi_Moneda     = Moneda.mnnemo  
                                                     ,           Modi_Moneda_Glosa    = Moneda.mnglosa  
                                                     ,           Modi_Monto      = Modificacda.camtomon1  
                                                     ,           Modi_TipoCambio    = Modificacda.catipcam  
                    ,           Modi_MonedaCnv     = MonCnv.mnnemo  
                                     ,           Modi_MonedaCnv_Glosa   = MonCnv.mnglosa  
                                                     ,           Modi_MontoCnv     = Modificacda.camtomon2  
                                                     ,           Modi_Fecha_Venciminto   = Modificacda.cafecvcto  
                                                     ,           Modi_MonedaReferencial   = MonRef.mnglosa  
                                                       
                                                     ,    Modi_Domicilio_Cli    = Cliente.Cldirecc  
                                                     ,    Modi_Fono_Cli     = Cliente.Clfono  
                                                     ,    Modi_Fax_Cli     = Cliente.Clfax  
                                                      
                                                     --select * from bacparamsuda..cliente where clrut = 97023000  
                                                     --select * from bacparamsuda..cliente where clrut = 87845500  
                                               from        BacFwdSuda.dbo.MfcaRes    Modificacda with(nolock)  
                                                                 inner join BacParamSuda.dbo.Cliente Cliente   with(nolock) On  Cliente.clrut           = Modificacda.cacodigo   
                                                                               and Cliente.clcodigo    = Modificacda.cacodcli  
                                                                 inner join BacParamSuda.dbo.Moneda Moneda      with(nolock) On  Moneda.mncodmon         = Modificacda.cacodmon1  
                                                                 inner join BacParamSuda.dbo.Moneda MonCnv      with(nolock) On  MonCnv.mncodmon         = Modificacda.cacodmon2  
                                                                 inner join BacParamSuda.dbo.Moneda MonRef      with(nolock) On  MonRef.mncodmon         = Modificacda.camdausd  
                                               where       --convert(char(10),cafechaproceso,105)    = @dFecha --> *** Para pruebas se desactivo  
                                               canumoper         = @nContrato  
                                                     UNION  
                                               select            Modi_Contrato                 = Modificacda.canumoper  
                                                     ,           Modi_Fecha_Cierre       = Modificacda.cafecha  
                                                     ,           Modi_Rut_Cliente        = ltrim(rtrim( Cliente.clrut )) + '-' + ltrim(rtrim( Cliente.cldv ))  
                                                     ,           Modi_Nombre_Cliente           = Cliente.clnombre  
                                                     ,           Modi_Comprador                = case when Modificacda.catipoper = 'C' then 'CORPBANCA'         ELSE Cliente.clnombre      END  
                                                     ,           Modi_Vendedor                 = case when Modificacda.catipoper = 'C' then Cliente.clnombre    ELSE 'CORPBANCA'        END  
                                                     ,           Modi_Tipo_Operacion           = case when Modificacda.catipoper = 'C' then 'Compra'                  else 'Venta'                  end   
                                                     ,           Modi_Modalidad                = case when Modificacda.catipmoda = 'C' then 'Compensación'            else 'Entrega Fisica'     end   
                                                     ,           Modi_Moneda                   = Moneda.mnnemo  
                                                     ,           Modi_Moneda_Glosa       = Moneda.mnglosa  
                                                     ,           Modi_Monto                    = Modificacda.camtomon1  
                   ,           Modi_TipoCambio               = Modificacda.catipcam  
                                                     ,           Modi_MonedaCnv                = MonCnv.mnnemo  
                                                     ,           Modi_MonedaCnv_Glosa    = MonCnv.mnglosa  
                                                     ,           Modi_MontoCnv                 = Modificacda.camtomon2  
                                                     ,           Modi_Fecha_Venciminto   = Modificacda.cafecvcto  
                                                     ,           Modi_MonedaReferencial  = MonRef.mnglosa  
                                                       
                                                     ,   Modi_Domicilio = Cliente.Cldirecc  
                                                     ,    Modi_Fono_Cli   = Cliente.Clfono  
                                                     ,    Modi_Fax_Cli   = Cliente.Clfax  
                                                       
                                                       
                                                       
                                               from        BacFwdSuda.dbo.Mfca            Modificacda with(nolock)  
                                                                 inner join BacParamSuda.dbo.Cliente Cliente   with(nolock) On  Cliente.clrut           = Modificacda.cacodigo   
                                                                                                                                                         and Cliente.clcodigo    = Modificacda.cacodcli  
                                                                 inner join BacParamSuda.dbo.Moneda Moneda      with(nolock) On  Moneda.mncodmon         = Modificacda.cacodmon1  
                      inner join BacParamSuda.dbo.Moneda MonCnv      with(nolock) On  MonCnv.mncodmon         = Modificacda.cacodmon2  
                                                                 inner join BacParamSuda.dbo.Moneda MonRef      with(nolock) On  MonRef.mncodmon         = Modificacda.camdausd  
                                               where       Modificacda.canumoper   = @nContrato  
  and               Modificacda.caestado    = 'M'  
                                               and               convert(char(10),Modificacda.cafecmod,105)    = @dFecha  
                                               and               Modificacda.cahora            = @cHora  
                                         )     Modificada  On    Modificada.Modi_Contrato      = Original.canumoper  
                          

                        --left  join  (     select      Folio             = Original.canumoper  
                        --                       ,           FechaAdendum      = MAX(Original.cafecmod)  
                        --                       from  BacFwdSuda.dbo.Mfca_log Original  
                        --                       where canumoper         = @nContrato  
                        --                       and         caestado          = 'M'  
                        --                      and         convert(char(10),cafecmod,105)          < @dFecha 
											   
                        --                       group   
                        --                       by          Original.canumoper  
                        --                 )     Adendum     On Adendum.Folio  = Original.canumoper  


								left join		( select 
												 FechaAdendum = datos.cafecmod
												
												from 
												(select 
												 ROW_NUMBER() OVER(ORDER BY cafecmod DESC) AS id
												,cafecmod
												,canumoper
												from  BacFwdSuda.dbo.Mfca_log with(nolock)  
																		where canumoper         = @nContrato 
																		 and   caestado    <> 'A'   
																					and caantici  <> 'A'  ) as datos
												where datos.id = 2)  Adendum on Adendum.FechaAdendum <> ''





            where Original.canumoper           = @nContrato  
            and         Original.caestado       = 'M'  
            and         convert(char(10),Original.cafecmod,105)       = @dFecha  
            and         Original.cahora              = @cHora  
      end  
end  
  
  
  
--end  
--Go  
--Execute dbo.Sp_Genera_Adendum_Forward 566767, 'Modificada', '20130715', '11:11:47'  
--Execute dbo.Sp_Genera_Adendum_Forward 556693, 'Modificada', '20130410', '14:11:44'  
--Execute dbo.Sp_Genera_Adendum_Forward 566767, 'Anticipo',      '20130715', '11:11:47'  
--Execute dbo.Sp_Genera_Adendum_Forward 563470, 'Anticipo',  '20130712', '00:00:00'  
  
  
--> select * from mfcares where canumoper = 556693  
--87845500-2  
--select * from bacparamsuda..cliente where clrut = 87845500  
  
--select * from bacparamsuda..CLIENTE_APODERADO where aprutcli = 87845500  
--select * from bacparamsuda..CLIENTE_APODERADO where aprutcli = 99579730  
--select * from bacparamsuda..CLIENTE_APODERADO where aprutcli = 97023000

GO
