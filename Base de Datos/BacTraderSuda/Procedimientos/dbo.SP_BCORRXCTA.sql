USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BCORRXCTA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BCORRXCTA] (@ctacorta  CHAR(15) ) 
AS 
                   
BEGIN
--declare @rut     NUMERIC ( 9) , 
--        @codigo  NUMERIC (9) 
-- SELECT @rut=cclrut , @codigo=cclcodig 
-- FROM MECC 
--     WHERE @ctacorta =cclctacorta
--if @rut = 0 
 SELECT cclctacorta,
        cclbanco,
        cclplaza,
        cclmoneda,
        cclcuenta,
        cclcswift,
        cclchips,
        cclaba,
        '',
        '',  
        '',
        cclnac
 FROM  MECC                         
 
 WHERE  @ctacorta =cclctacorta 
--else
-- SELECT cclctacorta,
--        cclbanco,
--        cclplaza,
--        cclmoneda,
--        cclcuenta,
--        cclcswift,
--        cclchips,
--        cclaba,
--        clrut,
--        clcodigo,  
--        clnombre,
--        cclnac
-- FROM MECC , VIEW_CLIENTE                        
 
-- WHERE  @ctacorta =cclctacorta and clrut=@rut and clcodigo=@codigo 
END

GO
