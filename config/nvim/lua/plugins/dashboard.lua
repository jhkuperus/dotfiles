return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function(_, dashboard)
    local logo = [[


              *                                                                  
             ***                                                                 
            *****                                                                
           *******                                                               
     YYYY  *******  YYYY     OOOOOOOOO       IIII  NNNN      NNNN  KKKK     KKKK 
      YYYY  *****  YYYY     OOOO   OOOO      IIII  NNNNN     NNNN  KKKK    KKKK  
       YYYY  ***  YYYY     OOOO     OOOO     IIII  NNNNNN    NNNN  KKKK   KKKK   
        YYYY  *  YYYY     OOOO       OOOO    IIII  NNNNNNN   NNNN  KKKK  KKKK    
         YYYY   YYYY     OOOO         OOOO   IIII  NNNNNNNN  NNNN  KKKK KKKK     
          YYYY YYYY     OOOO           OOOO  IIII  NNNN NNNN NNNN  KKKKKKKK      
          YYYY YYYY      OOOO         OOOO   IIII  NNNN  NNNNNNNN  KKKK KKKK     
          YYYY YYYY       OOOO       OOOO    IIII  NNNN   NNNNNNN  KKKK  KKKK    
          YYYY YYYY        OOOO     OOOO     IIII  NNNN    NNNNNN         KKKK   
          YYYY YYYY         OOOO   OOOO      IIII  NNNN     NNNNN  KKKK    KKKK  
          YYYY YYYY          OOOOOOOOO       IIII  NNNN      NNNN  KKKK     KKKK 



    ]]
    dashboard.config.header = vim.split(logo, "\n")
  end,
}
