USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DIRECCIONES_BONOS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INTERFAZ_DIRECCIONES_BONOS]

AS
BEGIN

DECLARE @registros   integer
DECLARE @FECHA       datetime
DECLARE @max         integer

select  @FECHA = (select acfecproc from text_arc_ctl_dri)
select  @max   = (select count(*) from text_rsu)

SET NOCOUNT ON
SELECT   
         'Cod_Familia'     = 'MDIR'                                                                                                                                                     --1
         ,'T_producto'     = 'MD01'   
         ,'rut'            = CONVERT(CHAR(9),A.rsrutcli)                                                                                                                                --3
         ,'dig'            = Cldv                                                                                                                                                       --4
         ,'n_operacion'    = convert(VARCHAR(7),A.rsnumdocu) +  CONVERT(VARCHAR(1),A.rscorrelativo) + CONVERT(VARCHAR(7),A.rsnumoper)                    						--5
         ,'maximo'         = @max                                                                                                                                                       --6
         ,'Direccion'      = ISNULL(B.Cldirecc,'')                                                                                                                                      --7  
         ,'Comuna'         = CASE WHEN B.Clcomuna = 0 THEN 9999 ELSE ISNULL(B.Clcomuna,0) END
         ,'Ciudad'         = CASE WHEN B.Clciudad = 0 THEN 9999 ELSE ISNULL(B.Clciudad,0) END
         ,'Fono'           = ISNULL(B.Clfono,0)                                                                                                                                         --10
         ,'fec_ult_act'    = B.Clfeculti                                                                                                                                                --11    
         into #temporal 
         FROM text_rsu A,VIEW_CLIENTE B
         WHERE (A.rsrutcli = B.Clrut AND A.rscodcli = B.Clcodigo)
                AND A.rsfecpro = @FECHA

    SELECT * FROM #TEMPORAL ORDER BY n_operacion

SET NOCOUNT OFF
END

GO
