USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GCORI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado DBO.SP_GCORI    fecha de la secuencia de comandos: 05/04/2001 13:13:25 ******/
CREATE PROCEDURE [dbo].[SP_GCORI]      (@lctacorta  char   (15),
                                @lrut       numeric( 9),
                                @lcodig     numeric( 9),
                                @lbanco     char   (50),                            
                                @lplaza     numeric( 3),                 
                                @lmoneda    char   ( 3),
                                @lcuenta    char   (30),     
                                @lswift     char   (11),
                                @lcodigo    numeric( 7),
                                @lvisua     char   ( 1),
                                @lchips     char   ( 6),
                                @laba       char   ( 9),
                                @lnac       char   ( 1),             
                                @entida     char   ( 2),  
                                @corres     numeric( 5) 
                               )
as
begin
        begin transaction  
 if exists (select * from MECC where cclctacorta = @lctacorta )
  begin
 
   update MECC  set  cclplaza  = @lplaza,                 
                           cclcuenta     = @lcuenta,                   
                                 cclrut        = @lrut,                               
                                    cclcodig      = @lcodig,  
                                    cclcswift     = @lswift,
                                    cclcodigo     = @lcodigo,
                                    cclvisua      = @lvisua,
                                    cclchips      = @lchips,
                                    cclmoneda     = @lmoneda,
                                    cclaba        = @laba, 
                                    cclbanco      = @lbanco,  
                                    cclnac        = @lnac  
   where cclctacorta = @lctacorta  -- cclrut = @lrut and  @corres=cclcorres and cclcodig=@lcodig 
 end   
 else
 
 begin 
      update VIEW_MEAC set accorres = accorres+1 where acentida = @entida
      select @corres= accorres from VIEW_MEAC where acentida = @entida
  
        insert MECC
              (cclctacorta,
               cclcorres,
  
              cclrut,
               cclcodig,
               cclbanco,
               cclplaza,
               cclmoneda,
               cclcuenta,              
               cclcswift,
               cclcodigo,
               cclvisua,  
     
           cclchips, 
               cclaba,
               cclnac  )    
        values (@lctacorta,
                @corres,
                @lrut,
                @lcodig,   
                @lbanco,
                @lplaza,                 
 
                @lmoneda,
                @lcuenta,     
                @lswift,
                @lcodigo,
                @lvisua,
                @lchips,
                @laba,
                @lnac  )
end    
 if @@error<>0
  begin
   rollback  
                        select  'NO'
   return
  
 end
 commit transaction
             select 'OK'
end             

GO
