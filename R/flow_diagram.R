grViz("
digraph {
      
      # graph attributes
      graph [overlap = true]
      
      # node attributes
      node [shape = box,
      fontname = Helvetica,
      color = blue]
      
      # edge attributes
      edge [color = gray]
      
      # node statements
      Healthy; Diseased; Dead
      
      
      # edge statements
      Healthy->Diseased  // gray
      Healthy->Dead  //red
      Diseased->Dead  //red
      Diseased->Healthy  //green
      }
      ")
