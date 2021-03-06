USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DIRECCIONES_FORWARD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_DIRECCIONES_FORWARD]  
  
AS  
BEGIN  
/* Cambio solicitado en e-mail:  
De: Patricio Rojas Vargas   
Enviado el: Lunes, 12 de Septiembre de 2005 8:55  
Para: María Paz Navarro Genta  
Asunto: RE: SOLICITUD DE VALIDACIONES DE Interfaces para ver como llegan las operaciones BFT  
TAG MPNG20050912  
Se infiere que al vencimiento ningún producto forwards debe aparecer en las interfaces.  
*/  
  
DECLARE @registros   integer  
DECLARE @FECHA       datetime  
DECLARE @max         integer  
  
select  @FECHA = (select acfecproc from MFAC)  
select  @max   = (select count(*) from mfca )  
  
SET NOCOUNT ON  
  
select  @FECHA = (select acfecproc from MFAC)  
  
  
-- Opciones  
-- Contratos Vigentes de Opciones  
Select distinct Enc.*, Det.CaFechaPagoEjer  into #Opciones from   LNKOPC.CbMdbOpc.dbo.CaDetContrato det  
                                           , LNKOPC.CbMdbOpc.dbo.CaEncContrato Enc  
where     Enc.CaNumContrato   = Det.CanumContrato  
      and Det.CaFechaPagoEjer > @FECHA  
  
  
select  @max   = (select count(1) from mfca ) + ( select count(1) from #Opciones )  
  
  
SELECT     
         'Cod_Familia'     = 'MDIR'       
         ,'T_producto'     = 'MD01'--ISNULL(case   
                             -- when A.cacodpos1 = 1 or A.cacodpos1 = 2 or A.cacodpos1 = 3   
                             -- then (select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BFW' and codigo_bac = convert(char(1),A.cacodpos1)+ convert(char(3),A.cacodmon2))  
                             -- else ''  
                             --end,'')  
         ,'rut'            = CONVERT(CHAR(9),A.cacodigo)                                                                                                                               --2  
         ,'dig'            = isnull(cldv,0) -- ISNULL((select Cldv FROM VIEW_CLIENTE where A.cacodigo = Clrut and A.cacodcli = B.Clcodigo),0)                                                            --3  
         ,'n_operacion'    = CAST(A.canumoper AS VARCHAR(9))                                                                                                 --4  
         ,'maximo'         = @max                                                                                                                                                      --5  
         ,'Direccion'      = ISNULL(B.Cldirecc,'')                                                                                                                                     --6    
         ,'Comuna'         = CASE WHEN B.Clcomuna = 0 THEN 9999 ELSE ISNULL(B.Clcomuna,0) END  
         ,'Ciudad'         = CASE WHEN B.Clciudad = 0 THEN 9999 ELSE ISNULL(B.Clciudad,0) END  
         ,'Fono'           = ISNULL(B.Clfono,0)                                                                                                                                        --9  
         ,'fec_ult_act'    = B.Clfeculti                                                                                                                                               --10      
           
         FROM MFCA A,VIEW_CLIENTE B  
         WHERE (A.cacodigo = B.Clrut AND A.cacodcli = B.Clcodigo)  
--         AND   (A.cafecha = @FECHA)  
           AND cafecvcto > @FECHA --TAG MPNG20050912  
  
union  -- Agregando la información de Opciones  
SELECT   distinct      
         'Cod_Familia'     = 'MDIR'       
         ,'T_producto'     = 'MD01'--ISNULL(case   
                             -- when A.cacodpos1 = 1 or A.cacodpos1 = 2 or A.cacodpos1 = 3   
                             -- then (select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BFW' and codigo_bac = convert(char(1),A.cacodpos1)+ convert(char(3),A.cacodmon2))  
                             -- else ''  
                             --end,'')  
         ,'rut'            = CONVERT(CHAR(9),A.CaRutCliente)   --  select * from lnkopc.CbMdbOpc.dbo.CaEncContrato                                                  --2  
         ,'dig'      = isnull(cldv,0) -- ISNULL((select Cldv FROM VIEW_CLIENTE where A.cacodigo = Clrut and A.cacodcli = B.Clcodigo),0)                                                            --3  
         ,'n_operacion'    = CAST(A.CaNumContrato AS VARCHAR(5))                                                                                                 --4  
         ,'maximo'         = @max                                                                                                                                                      --5  
         ,'Direccion'      = ISNULL(B.Cldirecc,'')                                                                                                                                     --6    
         ,'Comuna'         = CASE WHEN B.Clcomuna = 0 THEN 9999 ELSE ISNULL(B.Clcomuna,0) END  
         ,'Ciudad'         = CASE WHEN B.Clciudad = 0 THEN 9999 ELSE ISNULL(B.Clciudad,0) END  
         ,'Fono'           = ISNULL(B.Clfono,0)                                                                                                                                        --9  
         ,'fec_ult_act'    = B.Clfeculti                                                                                                                                               --10      
           
         FROM #Opciones  A,VIEW_CLIENTE B  
         WHERE (A.CaRutCliente = B.Clrut AND A.CaCodigo = B.Clcodigo)  
--         AND   (A.cafecha = @FECHA)  
           AND CaFechaPagoEjer > @FECHA --TAG MPNG20050912  
  
  
SET NOCOUNT OFF  
END 
 
GO
