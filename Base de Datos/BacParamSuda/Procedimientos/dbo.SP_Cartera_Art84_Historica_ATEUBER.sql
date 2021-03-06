USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_Cartera_Art84_Historica_ATEUBER]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SP_Cartera_Art84_Historica_ATEUBER]  
( @fecha as datetime )  
As  
Begin  
  
 SELECT FecP.acfecante, Resu.Modulo, Resu.Rut_Cliente, Resu.Codigo_Cliente, clnombre, Tot_Gen_Equiv_credito  
         , Total_Nocional_USD = round( sum( Operaciones.Nocional_CLP ) / VMC.Tipo_Cambio , 4 )  
         , Total_VR           = round( sum( Operaciones.AVR ) /  VMC.Tipo_Cambio, 4 )  
         , Cantidad           = count( Operaciones.AVR )    
         , Cantidad_Contratos = sum( case when Operaciones.AVR = 0 and Operaciones.Modulo = 'PCS' then 0 else 1 end )  
         , TCM                =  VMC.Tipo_Cambio  
 FROM BacTradersuda.dbo.RESUMEN_ART84_DERIVADOS  Resu         
  INNER JOIN BacParamSuda.dbo.cliente on  clrut = Resu.Rut_Cliente and clcodigo = Resu.Codigo_Cliente   
 , BacTradersuda.dbo.fechas_proceso       FecP  
    , BacTraderSuda.dbo.Art84_derivados      Operaciones    
    , BacParamSuda.dbo.valor_moneda_contable VMC   
  WHERE   Resu.fecha_proc = FecP.acfecante and  Resu.Modulo = 'Forward'      
         and Operaciones.Fecha_proc = FecP.acfecante  
         and Operaciones.Rut_Cliente = Resu.Rut_Cliente  
         and Operaciones.Codigo_Cliente = Resu.Codigo_Cliente           
         And VMC.Codigo_moneda = 994 and VMC.fecha = FecP.acfecante   
         and FecP.AcFecProc = @fecha   
    Group by FecP.acfecante, Resu.Modulo, resu.Rut_Cliente, Resu.Codigo_Cliente, clnombre, Tot_Gen_Equiv_credito ,  VMC.Tipo_Cambio      
 ORDER BY Rut_Cliente  
  --  dbo.SP_Cartera_Art84_Historica_ATEUBER_TMP '20120515'  
End
GO
