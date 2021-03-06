USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ADENDUM_ObtenerModificacionesFWD_Cliente]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--ADENDUM_ObtenerModificacionesFWD 45611  
--ADENDUM_ObtenerModificacionesFWD 558726

--ADENDUM_ObtenerModificacionesFWD_Cliente 90635000, 1, '2013/01/01','2013/03/31'

--ADENDUM_ObtenerModificacionesFWD_Cliente 90635000, 1, '20130101','20130331'



  
CREATE PROCEDURE [dbo].[ADENDUM_ObtenerModificacionesFWD_Cliente]  
(  
	--@nContrato AS numeric(9)  
	  @nRutCli AS NUMERIC(10) 
	, @CodCli as varchar(2)
	, @FechaDesde datetime --varchar(10)
	, @FechaHasta datetime --varchar(10)
)  
  
AS  
BEGIN  
SET NOCOUNT ON  
  
      --Declare @nContrato      numeric(9)  
        --    set @nContrato    = 566767  
--          set @nContrato    = 563720  
--          set @nContrato    = 559588  
          --set @nContrato    = 556693  
  --          set @nContrato    = 554557  
--            set @nContrato    = 563470  
 --set @nContrato    = 45611  
  

 --SELECT * FROM baclineas.dbo.DETALLE_APROBACIONES WHERE NUMERO_OPERACION = 558726 AND ID_SISTEMA = 'BFW' AND ESTADO = 'A'
  
--IF EXISTS (SELECT 1 FROM baclineas.dbo.DETALLE_APROBACIONES WHERE NUMERO_OPERACION = @nContrato AND ID_SISTEMA = 'BFW' AND ESTADO = 'A')  
 --BEGIN  

 
-- 	  --Variables formato fecha		  	    	    
--	    DECLARE @dia			VARCHAR(02)   
--		DECLARE @mes			VARCHAR(02)
--        DECLARE @año			VARCHAR(04)
--		DECLARE @Formatofecha VARCHAR(08)
----> Fecha Desde
--   SELECT @dia  = SUBSTRING(@FechaDesde,1,2)
--   select @mes  = SUBSTRING(@FechaDesde,4,2)
--   SELECT @año	= SUBSTRING(@FechaDesde,7,4) 

--    SELECT @Formatofecha = @año + @mes + @dia

--	set @FechaDesde = @Formatofecha

--	--> Fecha Hasta
--   SELECT @dia  = SUBSTRING(@FechaHasta,1,2)
--   select @mes  = SUBSTRING(@FechaHasta,4,2)
--   SELECT @año	= SUBSTRING(@FechaHasta,7,4) 

--    SELECT @Formatofecha = @año + @mes + @dia

--	set @FechaHasta = @Formatofecha


  
      select      Contrato    = Forward.Contrato  
            ,     Estado    = Forward.Estado  
			,	  Fecha_Contrato = convert(char(10), forward.cafecha,105)
            ,     Fecha_Modificacion    = convert(char(10),Forward.CafechaM,105)  
            ,     Hora_Modificacion     = Forward.Cahora  
            ,     Adendum    = Forward.Adendum  
            ,     Orden     = Forward.Orden  
            ,     id  
            ,  Folio     
      from  (     select      Contrato    = canumoper  
                             ,     Estado            = case      when caantici = 'A' and caestado = '' then 'Anticipo'  
                                                                 else 'Vigente'  
                                                           end  
                             ,     Orden       = case      when caantici = 'A' and caestado = '' then 3  
                                                                 else 1  
                                                          end  
							,		cafecha
                             ,     cafechaM = cafecha 
                             ,     cahora  
                             ,     Adendum           = case      when caantici = 'A' and caestado = '' then 'Si'  
                                                                 else 'No'  
                                                           end  
                             ,     id                = 1  
                             ,  Folio   = '---'  
                        from  BacFwdSuda.dbo.Mfca     with(nolock)  
                        --where canumoper   = @nContrato  
						where cacodigo = @nRutCli
						and cacodcli =   @CodCli
						and cafecha between @FechaDesde and @FechaHasta

						
  
                        union  
  
                        select      Contrato    = canumoper  
                             ,     Estado            = case      when caantici = 'A' and caestado = '' then 'Anticipo'  
                                                                 else 'Vencida'  
                                                           end  
                             ,     Orden       = case      when caantici = 'A' and caestado = '' then 3  
                                                                 else 4  
                                                           end  
							,		cafecha
                             ,     cafechaM  = cafecproc
							 
                             ,     cahora            = '00:00:00'  
                             ,     Adendum           = case      when caantici = 'A' and caestado = '' then 'Si'  
                                                                 else 'No'  
                                                           end  
                             ,     id                = 2  
                             ,  Folio   = '---'  
                        from  BacFwdSuda.dbo.MfcaH    with(nolock)  
                        --where canumoper   = @nContrato  
						where cacodigo = @nRutCli
						and cacodcli =   @CodCli
						and cafecproc between @FechaDesde and @FechaHasta
  
                        union  
  
                        select      Contrato    = canumoper  
                             ,     Estado            = case      when caestado = 'M' then 'Modificada'  
                                                                 when caestado = 'A' then 'Anulada'  
                                                                 else '--'  
                                                           end  
                             ,     Orden       = case      when caestado = 'M' then 2  
                                                                 when caestado = 'A' then 5  
                                   else -1  
                                                           end  
							,	cafecha
                             ,     cafechaM = cafecmod  
                             ,     cahora  
                              ,     Adendum           = case      when caestado = 'M' then 'Si'  
                                                                 when caestado = 'A' then 'No'  
                                                                 else 'No'  
                                                           end  
                             ,     id                = 3  
                             ,  Folio   = '---'  
                        from  BacFwdSuda.dbo.Mfca_log with(nolock)  
                        --where canumoper         = @nContrato  
                        --and   not ( caestado    = 'A'   
                        --            and caantici      = 'A'   
                        --           )  
						where cacodigo = @nRutCli
						and cacodcli =   @CodCli
						and caestado = 'M'
						--and cafecha between @FechaDesde and @FechaHasta
						and cafecmod between @FechaDesde and @FechaHasta


                  )     Forward  
       -- where Adendum = 'Si'  
      order  
      by          Forward.contrato Asc  
  
--END ELSE  
--BEGIN  
--     select TOP 0     
--     'Contrato'      = ''  
--   ,  'Estado'      = ''  
--   ,  'Fecha_Modificacion'   = ''  
--   ,  'Hora_Modificacion'       = ''  
--   ,  'Adendum'      = ''  
--   ,  'Orden'       = ''  
--   ,  'id'       = ''  
--   ,  'Folio'       = ''  
  
--   from BacFwdSuda.dbo.Mfca_Log    
--   where canumoper = @nContrato  
  
  
  
--END  
END
GO
