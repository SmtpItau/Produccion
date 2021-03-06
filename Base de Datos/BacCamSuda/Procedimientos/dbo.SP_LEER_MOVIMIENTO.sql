USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MOVIMIENTO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_MOVIMIENTO](
                  @numope  numeric(7)
                                    )
as
begin 
set nocount on
select monumope,motipmer,motipope,morutcli,mocodcli,monomcli
      ,mocodmon,mocodcnv,momonmo,moticam ,motctra ,moparme ,mopartr 
      ,moussme ,mousstr ,momonpe ,moentre ,morecib ,mooper ,moterm  
      ,mohora  ,mofech  ,mocodoma,moestatus,mocodejec,movaluta1
      ,movaluta2,morentab ,moalinea ,moentidad,moprecio ,mopretra ,id_sistema
      ,contabiliza,observacion ,swift_corresponsal ,swift_recibimos,swift_entregamos   
      ,plaza_corresponsal,plaza_recibimos,plaza_entregamos,forma_pago_cli_nac 
      ,forma_pago_cli_ext ,valuta_cli_nac,valuta_cli_ext,codigo_area
      ,codigo_comercio,codigo_concepto    
      from memo where monumope = @numope
set nocount off
end 



GO
