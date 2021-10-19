import java.util.Arrays;

int M = 5, N = 5;
boolean next = false;

int[][] grid = { { 0, 1, 0, 0, 0},
                 { 0, 0, 1, 0, 0},
                 { 1, 1, 1, 0, 0},
                 { 0, 0, 0, 0, 0},
                 { 0, 0, 0, 0, 0}
              };
              
int[][] empty_grid = { { 0, 0, 0, 0, 0},
                       { 0, 0, 0, 0, 0},
                       { 0, 0, 0, 0, 0},
                       { 0, 0, 0, 0, 0},
                       { 0, 0, 0, 0, 0}
              };
              
void setup() {
  size( 500, 500 ); // Size must be the first statement
}

void draw() {
  
      for (int i = 0; i < M; i++)
          for (int j = 0; j < N; j++)
              Cell(j*100, i*100, 100, 100, grid[i][j] == 1 );

      if(!Arrays.deepEquals(grid, empty_grid) && next){
      
            int[][] future = new int[M][N];
     
            // Loop through every cell
            for (int l = 0; l < M; l++)
                for (int m = 0; m < N; m++){
                    int aliveNeighbours = get(l-1, m-1)+ get(l-1, m)+ get(l-1, m+1)+
                                      get(l  , m-1)+              get(l  , m+1)+
                                      get(l+1, m-1)+ get(l+1, m)+ get(l+1, m+1);
     
                    // Cell dies
                    if ((grid[l][m] == 1) && (aliveNeighbours < 2 || aliveNeighbours > 3)) future[l][m] = 0;
                    // cell born
                    else if ((grid[l][m] == 0) && (aliveNeighbours == 3)) future[l][m] = 1;
                    else future[l][m] = grid[l][m];
                }      
            grid = future.clone();
            next = false;
      }     
}


void Cell(float x, float y, float w, float h, boolean alive) {
    stroke(0);
    fill(alive ? 0 : 255);
    rect(x,y,w,h);
}

int get(int r, int c){
        return ( (0 <= r && r < grid.length ) && ( 0 <= c && c < grid[r].length ) ) ? grid[r][c] : 0 ;
}

void mouseClicked() {
  if(!next) next = !next;
}
