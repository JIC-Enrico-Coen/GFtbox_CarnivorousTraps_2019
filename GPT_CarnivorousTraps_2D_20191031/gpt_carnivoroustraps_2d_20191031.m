function [m,result] = gpt_carnivoroustraps_2d_20191031( m, varargin )
%[m,result] = gpt_carnivoroustraps_2d_20191031( m, varargin )
%   Morphogen interaction function.
%   Written at 2019-10-31 13:54:22.
%   GFtbox revision 6030, 2019-03-06 16:30.

% The user may edit any part of this function lying between lines that
% begin "%%% USER CODE" and "%%% END OF USER CODE".  Those lines themselves
% delimiters themselves must not be moved, edited, deleted, or added.

    result = [];
    if isempty(m), return; end

    setGlobals();
    
    % Handle new-style callbacks.
    if nargin > 1
        if exist('ifCallbackHandler','file')==2
            [m,result] = ifCallbackHandler( m, varargin{:} );
        end
        return;
    end

    fprintf( 1, '%s found in %s\n', mfilename(), which(mfilename()) );

    realtime = m.globalDynamicProps.currenttime;
    dt = m.globalProps.timestep;

%%% USER CODE: INITIALISATION

% In this section you may modify the mesh in any way whatsoever.

    if (Steps(m)==0) && m.globalDynamicProps.doinit
        % Put any code here that should only be performed at the start of
        % the simulation.

        % All 2D models for Figure 4
        m.userdata.ranges.modelname.range = { 'MODEL6',...  % Figure 4 Q-S Left panel
                                              'MODEL7'};    % Figure 4 Q-S Right panel 
        m.userdata.ranges.modelname.index = 1;  % current model version
    end
    

    modelname = m.userdata.ranges.modelname.range{m.userdata.ranges.modelname.index};
    fprintf('\nRunning %s model %s\n',mfilename, modelname);
%%% END OF USER CODE: INITIALISATION

%%% SECTION 1: ACCESSING MORPHOGENS AND TIME.
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.

% Each call of getMgenLevels below returns four results:
% XXX_i is the index of the morphogen called XXX.
% XXX_p is the vector of all of its values.
% XXX_a is its mutation level.
% XXX_l is the "effective" level of the morphogen, i.e. XXX_p*XXX_a.
% In SECTION 3 of the automatically generated code, all of the XXX_p values
% will be copied back into the mesh.

    polariser_i = FindMorphogenRole( m, 'POLARISER' );
    P = m.morphogens(:,polariser_i);
    [kapar_i,kapar_p,kapar_a,kapar_l] = getMgenLevels( m, 'KAPAR' );  %#ok<ASGLU>
    [kaper_i,kaper_p,kaper_a,kaper_l] = getMgenLevels( m, 'KAPER' );  %#ok<ASGLU>
    [kbpar_i,kbpar_p,kbpar_a,kbpar_l] = getMgenLevels( m, 'KBPAR' );  %#ok<ASGLU>
    [kbper_i,kbper_p,kbper_a,kbper_l] = getMgenLevels( m, 'KBPER' );  %#ok<ASGLU>
    [knor_i,knor_p,knor_a,knor_l] = getMgenLevels( m, 'KNOR' );  %#ok<ASGLU>
    [strainret_i,strainret_p,strainret_a,strainret_l] = getMgenLevels( m, 'STRAINRET' );  %#ok<ASGLU>
    [arrest_i,arrest_p,arrest_a,arrest_l] = getMgenLevels( m, 'ARREST' );  %#ok<ASGLU>
    [id_adaxial_i,id_adaxial_p,id_adaxial_a,id_adaxial_l] = getMgenLevels( m, 'ID_ADAXIAL' );  %#ok<ASGLU>
    [id_abaxial_i,id_abaxial_p,id_abaxial_a,id_abaxial_l] = getMgenLevels( m, 'ID_ABAXIAL' );  %#ok<ASGLU>
    [id_midplane_i,id_midplane_p,id_midplane_a,id_midplane_l] = getMgenLevels( m, 'ID_MIDPLANE' );  %#ok<ASGLU>
    [s_adaxial_i,s_adaxial_p,s_adaxial_a,s_adaxial_l] = getMgenLevels( m, 'S_ADAXIAL' );  %#ok<ASGLU>
    [s_abaxial_i,s_abaxial_p,s_abaxial_a,s_abaxial_l] = getMgenLevels( m, 'S_ABAXIAL' );  %#ok<ASGLU>
    [v_radii_i,v_radii_p,v_radii_a,v_radii_l] = getMgenLevels( m, 'V_RADII' );  %#ok<ASGLU>
    [id_surface_i,id_surface_p,id_surface_a,id_surface_l] = getMgenLevels( m, 'ID_SURFACE' );  %#ok<ASGLU>
    [c_adaxial_i,c_adaxial] = getCellFactorLevels( m, 'c_adaxial' );
    [c_abaxial_i,c_abaxial] = getCellFactorLevels( m, 'c_abaxial' );
    [c_sector_i,c_sector] = getCellFactorLevels( m, 'c_sector' );
    [c_midplane_i,c_midplane] = getCellFactorLevels( m, 'c_midplane' );

% Mesh type: circle
%            asym: 0
%          centre: 0
%       circumpts: 0
%       coneangle: 0
%         dealign: 0
%       generalFE: 0
%          height: 0
%          hollow: 0
%        innerpts: 0
%          layers: 0
%             new: 1
%      randomness: 0
%           rings: 20
%      semicircle: 0
%       thickness: 0
%          xwidth: 2
%          ywidth: 2

%            Morphogen    Diffusion   Decay   Dilution   Mutant
%            --------------------------------------------------
%                KAPAR         ----    ----       ----     ----
%                KAPER         ----    ----       ----     ----
%                KBPAR         ----    ----       ----     ----
%                KBPER         ----    ----       ----     ----
%                 KNOR         ----    ----       ----     ----
%            POLARISER          0.1    0.01       ----     ----
%            STRAINRET         ----    ----       ----     ----
%               ARREST         ----    ----       ----     ----
%           ID_ADAXIAL         ----    ----       ----     ----
%           ID_ABAXIAL         ----    ----       ----     ----
%          ID_MIDPLANE         ----    ----       ----     ----
%            S_ADAXIAL         0.05    0.01       ----     ----
%            S_ABAXIAL         0.05    0.01       ----     ----
%              V_RADII         ----    ----       ----     ----
%           ID_SURFACE         ----    ----       ----     ----


%%% USER CODE: MORPHOGEN INTERACTIONS

% In this section you may modify the mesh in any way that does not
% alter the set of nodes.

    if (Steps(m)==0) && m.globalDynamicProps.doinit
        
        % setup different patterns of initial adaxial-abaxial system for each model
        switch modelname
            case 'MODEL6'
                center = [ 0, -1 ]; 
                SCALE = 1; 
                v_radii_p = sqrt((m.nodes(:,1) - center(1)).^2 + ((m.nodes(:,2)) * SCALE - center(2)).^2);
                id_adaxial_p(v_radii_p < 0.65) = 1; 
                id_abaxial_p(v_radii_p > 0.72) = 1; 
                
            case 'MODEL7'
                id_adaxial_p((abs(m.nodes(:,1)) < 0.1) & (m.nodes(:,2) < -0.15)) = 1;
                id_abaxial_p((abs(m.nodes(:,1)) > 0.15) | (m.nodes(:,2) > -0.1)) = 1;      
                v_radii_p = sqrt(m.nodes(:,1).^2 + m.nodes(:,2).^2);

        end
 
        % adaxial domain generate a diffusible singal S_ADAXIAL
        s_adaxial_p = id_adaxial_p;
        m.morphogenclamp((id_adaxial_p == 1) , s_adaxial_i) = 1;
        m = leaf_mgen_conductivity( m, 'S_ADAXIAL', 0.05 );
        m = leaf_mgen_absorption( m, 'S_ADAXIAL', 0.01 );

        % abaxial domain generate a diffusible singal S_ABAXIAL
        s_abaxial_p = id_abaxial_p;
        m.morphogenclamp((id_abaxial_p == 1), s_abaxial_i) = 1;
        m = leaf_mgen_conductivity( m, 'S_ABAXIAL', 0.05 ) ;
        m = leaf_mgen_absorption( m, 'S_ABAXIAL', 0.01 );
        
        % midplane domain is activated where both the signals fell below a threshold value
        id_midplane_p((s_adaxial_p < 0.6) & (s_abaxial_p < 0.6)) = 1;
        id_surface_p((sqrt(m.nodes(:,1).^2 + m.nodes(:,2).^2) > 0.95) & (~id_midplane_p)) = 1;
        
        % setup the white cells 
        cellcentres = biocellcentres( m );
        cell1 = ((cellcentres(:,1) > 0) & (cellcentres(:,1) < 0.5)) &...
                 ((cellcentres(:,2) > -0.2) & (cellcentres(:,2) < 0));   
        cell2 = ((cellcentres(:,1) > -0.4) & (cellcentres(:,1) < -0.2)) &...
                 ((cellcentres(:,2) > 0.6) & (cellcentres(:,2) < 0.8));                    
        cell3 = ((cellcentres(:,1) > -0.5) & (cellcentres(:,1) < -0.3)) &...
                 ((cellcentres(:,2) > -0.4) & (cellcentres(:,2) < -0.3));                    
        cell4 = ((cellcentres(:,1) > -1) & (cellcentres(:,1) < -0.9)) &...
                 ((cellcentres(:,2) > -0.1) & (cellcentres(:,2) < 0.05));                    
        cell5 = ((cellcentres(:,1) > 0.4) & (cellcentres(:,1) < 0.55)) &...
                 ((cellcentres(:,2) > -0.75) & (cellcentres(:,2) < -0.5));                    
        cell6 = ((cellcentres(:,1) > -0.6) & (cellcentres(:,1) < -0.4)) &...
                 ((cellcentres(:,2) > 0) & (cellcentres(:,2) < 0.3));                    
        cell7 = ((cellcentres(:,1) > -0.15) & (cellcentres(:,1) < 0.05)) &...
                 ((cellcentres(:,2) > -0.6) & (cellcentres(:,2) < -0.5));                    
        cell8 = ((cellcentres(:,1) > 0) & (cellcentres(:,1) < 0.15)) &...
                 ((cellcentres(:,2) > 0.1) & (cellcentres(:,2) < 0.4));                    
        cell9 = ((cellcentres(:,1) > 0.6) & (cellcentres(:,1) < 0.8)) &...
                 ((cellcentres(:,2) > 0.1) & (cellcentres(:,2) < 0.2));                    
        cell10 = ((cellcentres(:,1) > 0.45) & (cellcentres(:,1) < 0.65)) &...
                  ((cellcentres(:,2) > 0.65) & (cellcentres(:,2) < 0.8));
        c_sector(cell1 | cell2 | cell3 | cell4 | cell5 | cell6 | cell7 | cell8 | cell9 | cell10) = 1;
        
        % three cell factors were defined corresponding to the adaxial, abaxial, and midplane
        % regional identities
        switch modelname
            case 'MODEL6'
                RADII = sqrt((cellcentres(:,1) - center(1)).^2 +...
                             (cellcentres(:,2) * SCALE - center(2)).^2);
                c_adaxial(RADII < 0.65) = 1;  
                c_midplane(( RADII < 0.84) & (~c_adaxial)) = 1;
                c_abaxial((~c_adaxial) & (~c_midplane)) = 1;

            case 'MODEL7'
                c_adaxial(((abs(cellcentres(:,1)) < 0.15) & (cellcentres(:,2) < -0.1))) = 1;
                c_midplane((((abs(cellcentres(:,1)) < 0.3) & (cellcentres(:,2) < 0.08))) & (~c_adaxial)) = 1;
                c_abaxial((~c_adaxial) & (~c_midplane)) = 1;
                
        end
        
        % plotting cell factors
        m = leaf_plotoptions(m, 'cellfactor', {'c_adaxial','c_abaxial','c_midplane','c_sector'});
        m = leaf_plotpriority(m, {'c_adaxial','c_abaxial','c_midplane','c_sector'},...
                                 [ 1, 1, 1, 2 ], [ 0.5, 0.5, 0.5, 0.5 ], 'type', 'cellvalue');

    end
    
    % @@ PRN Polarity Regulatory Network
    % Pre-growth stage for generating the polarity field
    if (realtime <= 1 - 0.0001)          
        % Corresponding with the MODEL5 in GPT_Adab_3D_20191017, 
        % a single polarity field (orthoplanar) was established by a diffusible morphogen POL(POLARISER)
        % generated by a source at the surface(outer rim) and removed at a sink at the midplane
        
        P = id_surface_p - id_midplane_p;
        m.morphogenclamp((id_surface_p == 1) | (id_midplane_p == 1), polariser_i) = 1;
        m = leaf_mgen_conductivity(m, 'POLARISER', 0.1);
        m = leaf_mgen_absorption(m, 'POLARISER', 0.01);
        
    end
    
    % @@ KRN Growth Rate Regulatory Network
    % kapar/kbpar: growth rate paralle to the polarity field (Kop in the text)
    % kaper/kbper: growth rate perpendicular to the polarity field (Kper in the text) 
    
    if (realtime > 1 - 0.0001) && (realtime <= 7 - 0.0001)

        kapar_p(:) = 0.001;
        kaper_p(:) = 0.2;
        kbpar_p(:) = kapar_p;
        kbper_p(:) = kaper_p;
%         knor_p(:)  = 0;         % thickness of the canvas
        
    end
%%% END OF USER CODE: MORPHOGEN INTERACTIONS

%%% SECTION 3: INSTALLING MODIFIED VALUES BACK INTO MESH STRUCTURE
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.
    m.morphogens(:,polariser_i) = P;
    m.morphogens(:,kapar_i) = kapar_p;
    m.morphogens(:,kaper_i) = kaper_p;
    m.morphogens(:,kbpar_i) = kbpar_p;
    m.morphogens(:,kbper_i) = kbper_p;
    m.morphogens(:,knor_i) = knor_p;
    m.morphogens(:,strainret_i) = strainret_p;
    m.morphogens(:,arrest_i) = arrest_p;
    m.morphogens(:,id_adaxial_i) = id_adaxial_p;
    m.morphogens(:,id_abaxial_i) = id_abaxial_p;
    m.morphogens(:,id_midplane_i) = id_midplane_p;
    m.morphogens(:,s_adaxial_i) = s_adaxial_p;
    m.morphogens(:,s_abaxial_i) = s_abaxial_p;
    m.morphogens(:,v_radii_i) = v_radii_p;
    m.morphogens(:,id_surface_i) = id_surface_p;
    m.secondlayer.cellvalues(:,c_adaxial_i) = c_adaxial(:);
    m.secondlayer.cellvalues(:,c_abaxial_i) = c_abaxial(:);
    m.secondlayer.cellvalues(:,c_sector_i) = c_sector(:);
    m.secondlayer.cellvalues(:,c_midplane_i) = c_midplane(:);

%%% USER CODE: FINALISATION

% In this section you may modify the mesh in any way whatsoever.
%%% END OF USER CODE: FINALISATION

end

function [m,result] = ifCallbackHandler( m, fn, varargin )
    result = [];
    if exist(fn,'file') ~= 2
        return;
    end
    [m,result] = feval( fn, m, varargin{:} );
end


%%% USER CODE: SUBFUNCTIONS

% Here you may write any functions of your own, that you want to call from
% the interaction function, but never need to call from outside it.
% Remember that they do not have access to any variables except those
% that you pass as parameters, and cannot change anything except by
% returning new values as results.
% Whichever section they are called from, they must respect the same
% restrictions on what modifications they are allowed to make to the mesh.

