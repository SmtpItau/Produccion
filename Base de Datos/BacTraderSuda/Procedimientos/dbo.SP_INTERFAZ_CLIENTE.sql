USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_CLIENTE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_CLIENTE]
AS
BEGIN

DECLARE @Max                  INTEGER
DECLARE @total_registros      INTEGER
DECLARE @registros            INTEGER
DECLARE @registros2           INTEGER
DECLARE @rut_cliente          INTEGER
DECLARE @estado               INTEGER
         
SELECT @Max = (select count(*) from view_cliente)


SET NOCOUNT ON

SELECT 
       'Rut'         = ISNULL(Clrut,0)
      ,'Digito'      = ISNULL(Cldv,'')
      ,'Sucursal'    = '1'
      ,'Ejecutivo'   = convert( character(20), '' )
      ,'Nombres'     = SUBSTRING(Clnombre,1,40)
      ,'Estado'      = CASE WHEN EXISTS(SELECT 1 FROM MDCP  WHERE cprutcli = Clrut AND cpcodcli= Clcodigo) THEN 2
                            WHEN EXISTS(SELECT 1 FROM MDVI  WHERE virutcli = Clrut AND vicodcli= Clcodigo) THEN 2 
                            WHEN EXISTS(SELECT 1 FROM MDCI  WHERE cirutcli = Clrut AND cicodcli= Clcodigo) THEN 2
                            WHEN EXISTS(SELECT 1 FROM baccamsuda..MEMO  WHERE morutcli = Clrut AND mocodcli = Clcodigo) THEN 2
                            WHEN EXISTS(SELECT 1 FROM bacfwdsuda..MFCA  WHERE cacodcli = Clrut AND cacodigo= Clcodigo) THEN 2

                            -- Cartera de Opciones
                            WHEN EXISTS(SELECT 1 FROM LnkOpc.CbMdbOpc.dbo.CaEncContrato where CaRutCliente = ClRut and CaCodigo = ClCodigo ) THEN 2
                            ELSE 
                            1
                        END
      ,'Apellido_P'  = CASE WHEN Cltipcli = 8 THEN ISNULL(Clapelpa,'') ELSE '' END
      ,'Apellido_M'  = CASE WHEN Cltipcli = 8 THEN ISNULL(Clapelma,'') ELSE '' END
      ,'Direccion'   = ISNULL(Cldirecc,'')
      ,'Comuna'      = CASE WHEN Clcomuna = 0 THEN 9999 ELSE ISNULL(Clcomuna,0) END
      ,'Ciudad'      = CASE WHEN Clciudad = 0 THEN 9999 ELSE ISNULL(Clciudad,0) END
      ,'Fono'        = ' ' --> ISNULL(Clfono,0) )
      ,'FIngreso'    = ISNULL(CONVERT(CHAR(10),Clfecingr,103),'')
      ,'TipCliente'  = CASE WHEN Clrut < 50000000 THEN 1 ELSE 2 END -- ISNULL(Cltipcli,0)
      ,'Calidad'     = CASE WHEN Clcalidadjuridica <> 0 THEN Clcalidadjuridica ELSE '0' END
      ,'Fax'         = ISNULL(Clfax,'')
      ,'Clactivida'  = ISNULL(Clactivida,0)
      ,'SEconomico'  = CASE WHEN Clrut < 50000000 THEN '121'  ELSE ''  END --ISNULL(Clsector,0)
      ,'TipoEmp   '  = '9'
      ,'Maximo'      = @Max

      ,'F_act'      = ISNULL(CONVERT(CHAR(10),Fecact,112),'')
      ,'Segmento'   = CASE WHEN Clrut > 50000000 THEN 'EMPR' ELSE 'BPER' END -- ISNULL(Cltipcli,0)
      ,'EstadoCivil'= CASE WHEN Clrut > 50000000 THEN ''  ELSE '2'  END
into #salidaCL14
      FROM VIEW_CLIENTE

select * from #salidaCL14 order by estado

SET NOCOUNT OFF

END



GO
