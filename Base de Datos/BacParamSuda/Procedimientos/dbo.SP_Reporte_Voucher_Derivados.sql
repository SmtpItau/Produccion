USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_Reporte_Voucher_Derivados]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Reporte_Voucher_Derivados]
(   
    @fechaInicial datetime
  , @fechaFinal   datetime
  , @Cuenta       varchar(20) = ''
  , @Operacion    numeric(10) = 0
) As
Begin
    /*
	   Exec SP_Reporte_Voucher_Derivados '20140925' , '20140925', '212801034'

	   exec BacParamsuda.dbo.SP_Reporte_Voucher_Derivados '20140910', '20140910', '', 0
	   exec BacParamsuda.dbo.SP_Reporte_Voucher_Derivados '20150513', '20150513', '212801034', 0
	   
	*/
    set nocount on  
	SELECT Contabiliza = convert( char(10), 'Forward' )
	     , Origen = convert( char(10),  'SAO    ' )
	     , voucher_cnt.Fecha_Ingreso
		 , voucher_cnt.Numero_Voucher
		 , voucher_cnt.Glosa
		 , voucher_cnt.Operacion
		 , Componente = convert( numeric(5), 0 )
		 , voucher_cnt.Folio_Perfil
		 , MONEDA.mnnemo
		 , detalle_voucher_cnt.Correlativo
		 , detalle_voucher_cnt.Cuenta
		 , detalle_voucher_cnt.Tipo_Monto
		 , detalle_voucher_cnt.Monto
		 , Rut_Cliente = Convert( numeric(13), 0 )
		 , Codigo_Cliente = Convert( numeric(5), 0 )
		 , NOmbre_Cliente = Convert( char(50), '')
    into #Voucher
	FROM Bacfwdsuda.dbo.detalle_voucher_cnt detalle_voucher_cnt, 
		 BacParamSuda.dbo.MONEDA MONEDA, 
		 Bacfwdsuda.dbo.voucher_cnt voucher_cnt    
		 -- select * from  Bacfwdsuda.dbo.voucher_cnt where tipo_operacion like '%15%' order by fecha_ingreso desc
		 -- ( select opcContabExternaProd, * from CbMdbOpc.dbo.OpcionEstructura where opcContabExternaProd <> 'NA' )
	WHERE voucher_cnt.Numero_Voucher = detalle_voucher_cnt.Numero_Voucher 
	  AND detalle_voucher_cnt.Moneda = MONEDA.mncodmon  
	  AND voucher_cnt.Fecha_Ingreso >= @fechaInicial
	  AND voucher_cnt.Fecha_Ingreso <= @fechaFinal
	  AND ( detalle_voucher_cnt.Cuenta = @Cuenta or @Cuenta = '' )
	  and ( voucher_cnt.operacion = @Operacion or @Operacion = 0 )
	  and (  voucher_cnt.Tipo_Operacion like '%15%' or voucher_cnt.Tipo_Operacion like '%17%' )
	  
  union
  	SELECT Contabiliza = 'Forward'
	     , Origen = 'Forward'
	     , voucher_cnt.Fecha_Ingreso
		 , voucher_cnt.Numero_Voucher
		 , voucher_cnt.Glosa
		 , voucher_cnt.Operacion
		 , Componente = 0
		 , voucher_cnt.Folio_Perfil
		 , MONEDA.mnnemo
		 , detalle_voucher_cnt.Correlativo
		 , detalle_voucher_cnt.Cuenta
		 , detalle_voucher_cnt.Tipo_Monto
		 , detalle_voucher_cnt.Monto
		 , Rut_Cliente = Convert( numeric(13), 0 )
		 , Codigo_Cliente = Convert( numeric(5), 0 )
		 , NOmbre_Cliente = Convert( char(50), '')    
	FROM Bacfwdsuda.dbo.detalle_voucher_cnt detalle_voucher_cnt, 
		 BacParamSuda.dbo.MONEDA MONEDA, 
		 Bacfwdsuda.dbo.voucher_cnt voucher_cnt    
		 -- select * from  Bacfwdsuda.dbo.voucher_cnt where tipo_operacion like '%15%' order by fecha_ingreso desc
		 -- ( select opcContabExternaProd, * from CbMdbOpc.dbo.OpcionEstructura where opcContabExternaProd <> 'NA' )
	WHERE voucher_cnt.Numero_Voucher = detalle_voucher_cnt.Numero_Voucher 
	  AND detalle_voucher_cnt.Moneda = MONEDA.mncodmon  
	  AND voucher_cnt.Fecha_Ingreso >= @fechaInicial
	  AND voucher_cnt.Fecha_Ingreso <= @fechaFinal
	  AND ( detalle_voucher_cnt.Cuenta = @Cuenta or @Cuenta = '' )
	  and ( voucher_cnt.operacion = @Operacion or @Operacion = 0 )
	  and not(  voucher_cnt.Tipo_Operacion like '%15%' or voucher_cnt.Tipo_Operacion like '%17%' )  
	union
	SELECT Contabiliza = 'SAO    '
	     , Origen      = 'SAO    '
	     , voucher_cnt.Fecha_Ingreso
		 , voucher_cnt.Numero_Voucher
		 , voucher_cnt.Glosa
		 , voucher_cnt.Operacion
		 , Componente = voucher_cnt.Componente 
		 , voucher_cnt.Folio_Perfil
		 , MONEDA.mnnemo
		 , detalle_voucher_cnt.Correlativo
		 , detalle_voucher_cnt.Cuenta
		 , detalle_voucher_cnt.Tipo_Monto
		 , detalle_voucher_cnt.Monto
		 , Rut_Cliente = Convert( numeric(13), 0 )
		 , Codigo_Cliente = Convert( numeric(5), 0 )
		 , Nombre_Cliente = Convert( char(50), '')
	FROM CbMdbOpc.dbo.OpcDetalleVoucher detalle_voucher_cnt, 
		 BacParamSuda.dbo.MONEDA MONEDA, 
		 CbMdbOpc.dbo.OpcVoucher voucher_cnt
	WHERE voucher_cnt.Numero_Voucher = detalle_voucher_cnt.Numero_Voucher 
	  AND detalle_voucher_cnt.Moneda = MONEDA.mncodmon 
	  AND voucher_cnt.Fecha_Ingreso >= @fechaInicial
	  AND voucher_cnt.Fecha_Ingreso <= @fechaFinal
	  AND ( detalle_voucher_cnt.Cuenta = @Cuenta or @Cuenta = '' )
	  and ( voucher_cnt.operacion = @Operacion or @Operacion = 0 )

	union
	SELECT Contabiliza = 'Swap   '
	     , Origen      = 'Swap   '
	     , voucher_cnt.Fecha_Ingreso
		 , voucher_cnt.Numero_Voucher
		 , voucher_cnt.Glosa 
		 , Operacion =   convert( numeric(10), substring(  ltrim( rtrim( convert( varchar(10) , voucher_cnt.Operacion ) ) ), 1, len(  ltrim( rtrim( convert( varchar(10) , voucher_cnt.Operacion ) ) ) ) - 3 ) )
		 , Componente =  convert( numeric(10), substring(  ltrim( rtrim( convert( varchar(10) , voucher_cnt.Operacion ) ) ), len(  ltrim( rtrim( convert( varchar(10) , voucher_cnt.Operacion ) ) ) ) - 2, 3 ) )
		 , voucher_cnt.Folio_Perfil
		 , MONEDA.mnnemo
		 , detalle_voucher_cnt.Correlativo
		 , detalle_voucher_cnt.Cuenta
		 , detalle_voucher_cnt.Tipo_Monto
		 , detalle_voucher_cnt.Monto
		 , Rut_Cliente = Convert( numeric(13), 0 )
		 , Codigo_Cliente = Convert( numeric(5), 0 )
		 , NOmbre_Cliente = Convert( char(50), '')
	FROM BacSwapSuda.dbo.BAC_CNT_DETALLE_VOUCHER detalle_voucher_cnt, 
		 BacParamSuda.dbo.MONEDA MONEDA, 
		 BacSwapSuda.dbo.BAC_CNT_VOUCHER voucher_cnt
	WHERE voucher_cnt.Numero_Voucher = detalle_voucher_cnt.Numero_Voucher 
	  AND detalle_voucher_cnt.Moneda = MONEDA.mncodmon 
 	  AND voucher_cnt.Fecha_Ingreso >= @fechaInicial
	  AND voucher_cnt.Fecha_Ingreso <= @fechaFinal
	  AND ( detalle_voucher_cnt.Cuenta = @Cuenta or @Cuenta = '' )
	  and ( voucher_cnt.operacion = @Operacion or @Operacion = 0 )
	  

    update #Voucher set  Rut_Cliente = E.CaRutCliente 
	                   , Codigo_Cliente =  E.CaCodigo 					   
      from CbMdbOpc.dbo.CaEncContrato E 
	  where Operacion = E.CaNumContrato
	    and Origen = 'SAO'

    update #Voucher set  Rut_Cliente = E.CaRutCliente 
	                   , Codigo_Cliente =  E.CaCodigo 					   
      from CbMdbOpc.dbo.CaVenEncContrato E 
	  where Operacion = E.CaNumContrato
	    and Origen = 'SAO'


   update #Voucher set  Rut_Cliente = E.CaCodigo
	                   , Codigo_Cliente =  E.CaCodCli
      from BacFwdSuda.dbo.Mfca E 
	  where Operacion = E.CaNumOper
	    and Origen = 'Forward'

   update #Voucher set  Rut_Cliente = E.CaCodigo
	                   , Codigo_Cliente =  E.CaCodCli
      from BacFwdSuda.dbo.Mfcah E 
	  where Operacion = E.CaNumOper
	    and Origen = 'Forward'
  
   update #Voucher set  Rut_Cliente = E.Rut_Cliente
	                   , Codigo_Cliente =  E.Codigo_Cliente
      from BacSwapSuda.dbo.cartera E 
	  where Operacion = E.Numero_Operacion
	    and Contabiliza = 'Swap' and Origen = 'Swap'

   update #Voucher set  Rut_Cliente = E.Rut_Cliente
	                   , Codigo_Cliente =  E.Codigo_Cliente
      from BacSwapSuda.dbo.CarteraHis  E 
	  where Operacion = E.Numero_Operacion
	    and Contabiliza = 'Swap' and Origen = 'Swap'


	update #Voucher set NOmbre_Cliente = substring( ClNombre, 1, 50 ) from
		BacParamSuda.dbo.Cliente Cl where Cl.Clrut = Rut_Cliente 
		                              and Cl.Clcodigo = Codigo_Cliente 
									    
   
    select * from #Voucher order by Cuenta, origen, Contabiliza 

End
GO
