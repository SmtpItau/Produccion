USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_ActualizaFormaPagoEntregaFisica]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ActualizaFormaPagoEntregaFisica]   -- sp_helptext SP_ActualizaFormaPagoEntregaFisica
       (
         @NumeroContrato         NUMERIC(08)
       , @NumeroEstructura       NUMERIC(06)
       , @FormaPagoPagar         NUMERIC(05)
       , @FormaPagoRecibir       NUMERIC(05)
       )
AS
BEGIN

    -- SP_ActualizaFormaPagoEntregaFisica 954, 1,  129 , 13
--select * from lnkbac.bacparamsuda.dbo.forma_de_pago

    SET NOCOUNT ON

    DECLARE @Status              INT
    Declare @ExisteCaja          VarChar(1)
    Declare @EstadoEjercicio     VarChar(1)
    Declare @FormaPago01         Numeric(05)
    Declare @FormaPago02         Numeric(05)
    Declare @CaCajMtoMon1        Numeric(24,4)
    Declare @CntRegistros        INT


    -- CREA TABLA DE RESULTADO
    CREATE TABLE #tmpResult
    (
      RegType                VARCHAR(04) NOT NULL DEFAULT ''
    , Error                  INT         NOT NULL DEFAULT 0
    , FilasModificadas       INT         NOT NULL DEFAULT 0
    )

    select @CntRegistros    = 0
    select @ExisteCaja      = 'N' 
    select @EstadoEjercicio = 'P'   

    Select @ExisteCaja   = 'S'
         , @CaCajMtoMon1    = CaCajMtoMon1 
         , @EstadoEjercicio = case when CaCajEstado <> 'P' then CaCajEstado else @EstadoEjercicio end  
           -- Rescata solo si no esta pendiente
       from CaCaja 
         where   CaNumContrato   = @NumeroContrato
              and CaCajOrigen    = 'PV'                
              -- Entrega Fisica Es solo para Vcto

         --    and  CaNumEstructura = @NumeroEstructura
         --    Se comenta para realizar el cambio sobre todo
         --    el contrato
     
    -- Por logica de Opciones
    -- Para inferir Forma Pago 1 y dos se debe mirar un componente
    Select @FormaPago01 = case when    ( Det.CaCVOpc = 'C' and Det.CaCallput = 'Call' ) 
                                     or ( Det.CaCVOpc = 'V' and Det.CaCallput = 'Put' )
                                then @FormaPagoRecibir 
                                else @FormaPagoPagar end  
       from CaDetContrato Det 
    where   CaNumContrato = @NumeroContrato
       and  CaNumEstructura = @NumeroEstructura 


    -- Por complemento lógico
    Select @FormaPago02 = case when @FormaPago01 = @FormaPagoRecibir 
                                then @FormaPagoPagar 
                                else @FormaPagoRecibir end 

    if @EstadoEjercicio = 'P' begin
       update CaDetContrato  
          Set CaFormaPagoMon1 = @FormaPago01
            , CaFormaPagoMon2 = @FormaPago02
          where CaNumContrato = @NumeroContrato        
       Select @CntRegistros = @CntRegistros + @@rowcount

       if @ExisteCaja = 'S'  begin
          Update CaCaja
             Set   CaCajFormaPagoMon1 = @FormaPago01
                 , CaCajFormaPagoMon2 = @FormaPago02
          where CaNumContrato = @NumeroContrato 
          Select @CntRegistros = @CntRegistros + @@rowcount
       end
       -- Formato de Retorno
       SET @Status = @@ERROR
       INSERT #tmpResult
       SELECT RegType          = 'DET'
            , Error            = @Status
            , FilasModificadas = @CntRegistros
    end
    else  begin
       -- Formato de Retorno
       INSERT #tmpResult
       SELECT RegType          = ''
            , Error            = 0
            , FilasModificadas = @CntRegistros
    end
    -- RETORNA EL STATUS DE LA ACTUALIZACION
    SELECT RegType
         , Error
         , FilasModificadas
      FROM #tmpResult

END

GO
