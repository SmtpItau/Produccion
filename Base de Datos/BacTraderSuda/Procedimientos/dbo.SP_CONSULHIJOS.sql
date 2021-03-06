USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULHIJOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONSULHIJOS] 
                                (@rutpadre numeric(10),
     @codigo   numeric( 3) )
as
begin     
 select  clrut_hijo    ,
  clcodigo_hijo ,
  clporcentaje  ,
  (select clnombre  from VIEW_CLIENTE where clrut = clrut_hijo)
 
        from
         VIEW_CLIENTE_RELACIONADO 
      where
         clrut_padre    = @rutpadre and
                clcodigo_padre = @codigo
  
      
 order by clrut_hijo
   
end  

GO
