USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTAB]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[SP_RENTAB]
            ( @entidad   char(2) )
as
begin
set nocount on
     select a.acposini,
            a.acpreini,
            a.acposic, 
            CASE WHEN ACPOSIC > 0 and (ACPMECO <>0) THEN (SELECT TOP 1 fSpotCom  FROM BacFwdsuda..MF_TASAS_MTM WHERE   Moneda =13)
                                    WHEN ACPOSIC <= 0 and (ACPMEVE <>0)THEN (SELECT TOP 1 fSpotVen  FROM BacFwdsuda..MF_TASAS_MTM WHERE   Moneda =13)
                                    ELSE ACPRECIE END,
            a.actotco, 
            a.acpmeco, 
            a.actotve, 
            a.acpmeve, 
            c.vmvalor, 
            0, 
            a.actcamar,
            a.actovern,
            0, 
            0, 
            'tc_posact' = CASE WHEN a.ACPOSIC > 0 and (a.ACPMECO <>0) THEN  a.ACPMECO 
                               WHEN a.ACPOSIC <= 0 and (a.ACPMEVE <>0) THEN  a.ACPMEVE 
                               ELSE a.ACPREINI END ,
            'Descalce'  = (ACHEDGEACTUALFUTURO + ACHEDGEACTUALSPOT) + (achedgevctofuturo)
 
       from MEAC  a,
            VIEW_VALOR_MONEDA  c
      where a.acentida       = @entidad
        and c.vmcodigo       = 994   
        and convert(char(8),c.vmfecha,112) = convert(char(8),a.acfecant,112)
set nocount off
end

GO
