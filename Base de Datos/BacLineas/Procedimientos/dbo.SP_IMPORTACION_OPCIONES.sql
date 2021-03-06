USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPORTACION_OPCIONES]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_IMPORTACION_OPCIONES]
   (    
   	@Usuario	CHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

      SELECT  'NumCont'     = NumContrato
            , 'TipoTrans'   = TipoTransaccion 
            , 'NumFolio'    = NumFolio
            , 'FecCont'     = FechaContrato               
            , 'Estado'      = Estado  
            , 'RutCli'      = RutCliente  
            , 'CodCli'      = Codigo      
            , 'Usuario'     = Usuario         
            , 'CodEstruc'   = CodEstructura 
            , 'CVEstruc'    = CVEstructura 
            , 'Estado_Oper' = Estado_Oper           
      INTO #OPER_APROBADAS
      FROM  BacLineas.dbo.TAB_Importada_MoEncContrato         
      WHERE Estado_Oper = 'A'
      

       UPDATE LnkOpc.CbMdbOpc.dbo.MoEncContrato
       SET   MoEstado  = ' '
       FROM  BacLineas.dbo.TAB_Importada_MoEncContrato
       WHERE Usuario =  @Usuario 
       AND   Estado_Oper = 'A'    
       -- MAP 09 Octubre 2009
       AND   NumContrato = MoNumContrato

       DELETE BacLineas.dbo.TAB_Importada_MoEncContrato  
       FROM #OPER_APROBADAS A         
       WHERE  A.NumCont = NumContrato


       DELETE   BacLineas.dbo.TAB_Importada_MoEncContrato  
       WHERE Usuario = @Usuario 



       select MoNumContrato into #Anuladas 
       from LnkOpc.CbMdbOpc.dbo.MoEncContrato where MoTipoTransaccion = 'ANULA'


       DELETE   BacLineas.dbo.TAB_Importada_MoEncContrato  
       WHERE NumContrato IN( select MoNumContrato from #Anuladas )



       INSERT dbo.TAB_Importada_MoEncContrato
       SELECT MoNumFolio
            , MoTipoTransaccion
            , MoNumContrato
            , MoFechaContrato
            , MoEstado
            , MoRutCliente
            , MoCodigo
            , @Usuario
            , MoCodEstructura
            , MoCVEstructura
            , ''
        FROM  LnkOpc.CbMdbOpc.dbo.MoEncContrato 
        WHERE MoEstado = 'P'  and MoNumcontrato not in ( select MoNumContrato from #Anuladas )

   SET NOCOUNT OFF

END
GO
