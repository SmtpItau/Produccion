USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_CLIENTE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_CLIENTE]      
   (   @rut          NUMERIC(10)      
   ,   @dv           CHAR(1)      
   ,   @codigo       NUMERIC(5)      
   ,   @nombre       CHAR(70)      
   ,   @tipo         NUMERIC(5)      
   ,   @cTelefono    CHAR(20) = ''      
   ,   @cUsuario     CHAR(15)      
   )      
AS      
BEGIN      
      
   SET NOCOUNT ON      
      
 SET @dv = UPPER(@dv)  
  
   DECLARE @dFecha_Proc   DATETIME      
       SET @dFecha_Proc   = (SELECT acfecpro FROM MEAC with(nolock) )      
      
   SET @nombre = SUBSTRING(@nombre, 1, 60)      
      
   IF  @codigo = 0      
       SET @codigo = ISNULL( (SELECT MIN( clcodigo )      
                                FROM BacParamSuda.dbo.CLIENTE with(nolock)       
                               WHERE clrut    = @rut      
                                 AND clcodigo > 0) , 1)      
      
   IF @codigo IS NULL      
      SET @codigo = 1      
         
   IF EXISTS( SELECT 1 FROM VIEW_CLIENTE WHERE clrut = @rut AND clcodigo = @codigo)      
   BEGIN      
      UPDATE VIEW_CLIENTE      
         SET clnombre   = @nombre      
         ,   cltipcli   = @tipo      
         ,   clfono     = @ctelefono      
         ,   fecact     = @dFecha_Proc      
       WHERE clrut      = @rut       
         AND clcodigo   = @codigo      
      
   END ELSE       
   BEGIN      
      INSERT INTO VIEW_CLIENTE       
      (   clrut      
      ,   cldv      
      ,   clcodigo      
      ,   clnombre      
      ,   cltipcli      
      ,   clfono      
      ,   clfecingr      
      ,   fecact      
      ,   clcomuna      
      ,   clregion      
      ,   clpais      
      )      
      VALUES      
      (   @rut       
      ,   @dv        
      ,   @codigo      
      ,   @nombre      
      ,   @tipo      
      ,   @ctelefono      
      ,   @dFecha_Proc      
      ,   @dFecha_Proc      
      ,   3201      
      ,   13      
      ,   6      
      )      
       
   /* Agregar al nuevo cliente en tabla de bloqueos con todos los bloqueos y código 0. PRD -6066   */    
 ---> si el cliente ya está parametrizado en Bloqueos aún cuando no exista en el maestro de Clientes, no agregarlo    
 IF NOT EXISTS(SELECT 1 FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES WHERE rutCliente = @rut AND codCliente = @codigo)  
 BEGIN  
   INSERT INTO BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES    
   (rutCliente    
   ,codCliente    
   ,blqTodos    
   ,blqForward    
   ,blqSwaps    
   ,blqOpciones    
   ,blqSpot    
   ,blqPactos    
   ,codMotivo)    
   VALUES (@rut    
   ,@codigo    
   ,'N' --- Todos  
   ,'S' --- Forward    
   ,'S' --- Swap    
   ,'S' --- Opciones    
   ,'N' --- Spot  
   ,'S'  --- Pactos    
   ,0)  --- Motivo de Bloqueo    
   END  
   /* Fin PRD-6066 */    
    
       
   END      
      
   SELECT 'OK'       
      
END  
GO
