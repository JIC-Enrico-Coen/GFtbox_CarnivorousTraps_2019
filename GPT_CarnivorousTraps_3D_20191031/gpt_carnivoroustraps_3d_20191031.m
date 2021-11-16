function [m,result] = gpt_carnivoroustraps_3d_20191031( m, varargin )
%[m,result] = gpt_carnivoroustraps_3d_20191031( m, varargin )
%   Morphogen interaction function.
%   Written at 2019-10-31 13:55:28.
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
    if (Steps(m)==0) && m.globalDynamicProps.doinit
        % Put any code here that should only be performed at the start of
        % the simulation.

        % All 3D models for Figure 4
        if m.globalProps.IFsetsoptions
            m = setUpModelOptions( m, 'modelname',{...
                'MODEL1',...    % Figure 4  A-C  Tapering cylinder model
                'MODEL2',...    % Figure 4  D-G  Flat sheet model
                'MODEL3',...    % Figure 4  H-I  Tapering elliptic cylinder model (e.g. Utricularia leaflet)
                'MODEL4',...    % Figure 4  J-L  Cup model (e.g. Utricularia trap)
                'MODEL5',...    % Figure 4  M-P  Sarracenia pitcher leaf model
                }, 'MODEL4' );  % current model version  
        end

        % Any further initialisation here.
        
        % setup latitudinal and longitudinal grid
        m = leaf_makesecondlayer( m, 'mode', 'latlong', 'hemisphere', 'n',...  
                                     'subdivisions', 40,...
                                     'divisions', [16 8],...
                                     'add', true );
                                 
        % setup the arrow color of second polarity                         
        m = leaf_plotoptions( m, 'bioAalpha', 0,...                          
                                 'highgradcolor2', [0.9, 0.1, 0.1],...         
                                 'lowgradcolor2',[0.9, 0.1, 0.1],...
                                 'arrowthickness', 3 );
    end
    
    OPTIONS = getModelOptions( m );
    printModelOptions( m );
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

    [kpar_i,kpar_p,kpar_a,kpar_l] = getMgenLevels( m, 'KPAR' );  %#ok<ASGLU>
    [kpar2_i,kpar2_p,kpar2_a,kpar2_l] = getMgenLevels( m, 'KPAR2' );  %#ok<ASGLU>
    [kper_i,kper_p,kper_a,kper_l] = getMgenLevels( m, 'KPER' );  %#ok<ASGLU>
    [pol_i,pol_p,pol_a,pol_l] = getMgenLevels( m, 'POL' );  %#ok<ASGLU>
    [pol2_i,pol2_p,pol2_a,pol2_l] = getMgenLevels( m, 'POL2' );  %#ok<ASGLU>
    [id_adaxial_i,id_adaxial_p,id_adaxial_a,id_adaxial_l] = getMgenLevels( m, 'ID_ADAXIAL' );  %#ok<ASGLU>
    [id_abaxial_i,id_abaxial_p,id_abaxial_a,id_abaxial_l] = getMgenLevels( m, 'ID_ABAXIAL' );  %#ok<ASGLU>
    [id_midplane_i,id_midplane_p,id_midplane_a,id_midplane_l] = getMgenLevels( m, 'ID_MIDPLANE' );  %#ok<ASGLU>
    [id_surface_i,id_surface_p,id_surface_a,id_surface_l] = getMgenLevels( m, 'ID_SURFACE' );  %#ok<ASGLU>
    [id_base_i,id_base_p,id_base_a,id_base_l] = getMgenLevels( m, 'ID_BASE' );  %#ok<ASGLU>
    [s_adaxial_i,s_adaxial_p,s_adaxial_a,s_adaxial_l] = getMgenLevels( m, 'S_ADAXIAL' );  %#ok<ASGLU>
    [s_abaxial_i,s_abaxial_p,s_abaxial_a,s_abaxial_l] = getMgenLevels( m, 'S_ABAXIAL' );  %#ok<ASGLU>
    [v_center_i,v_center_p,v_center_a,v_center_l] = getMgenLevels( m, 'V_CENTER' );  %#ok<ASGLU>
    [v_radii_i,v_radii_p,v_radii_a,v_radii_l] = getMgenLevels( m, 'V_RADII' );  %#ok<ASGLU>
    [id_prox_i,id_prox_p,id_prox_a,id_prox_l] = getMgenLevels( m, 'ID_PROX' );  %#ok<ASGLU>
    [id_dist_i,id_dist_p,id_dist_a,id_dist_l] = getMgenLevels( m, 'ID_DIST' );  %#ok<ASGLU>
    [v_dist_i,v_dist_p,v_dist_a,v_dist_l] = getMgenLevels( m, 'V_DIST' );  %#ok<ASGLU>
    [v_tip_i,v_tip_p,v_tip_a,v_tip_l] = getMgenLevels( m, 'V_TIP' );  %#ok<ASGLU>

% Mesh type: volumetric

%            Morphogen    Diffusion   Decay   Dilution   Mutant
%            --------------------------------------------------
%                 KPAR         ----    ----       ----     ----
%                KPAR2         ----    ----       ----     ----
%                 KPER         ----    ----       ----     ----
%                  POL          0.1    0.01       ----     ----
%                 POL2          0.1    0.01       ----     ----
%           ID_ADAXIAL         ----    ----       ----     ----
%           ID_ABAXIAL         ----    ----       ----     ----
%          ID_MIDPLANE         ----    ----       ----     ----
%           ID_SURFACE         ----    ----       ----     ----
%              ID_BASE         ----    ----       ----     ----
%            S_ADAXIAL         0.05    0.01       ----     ----
%            S_ABAXIAL         0.05    0.01       ----     ----
%             V_CENTER         ----    ----       ----     ----
%              V_RADII         ----    ----       ----     ----
%              ID_PROX         ----    ----       ----     ----
%              ID_DIST         ----    ----       ----     ----
%               V_DIST         ----    ----       ----     ----
%                V_TIP         ----    ----       ----     ----


%%% USER CODE: MORPHOGEN INTERACTIONS

% In this section you may modify the mesh in any way that does not
% alter the set of nodes.

    if (Steps(m)==0) && m.globalDynamicProps.doinit

        % setup different patterns of initial adaxial-abaxial system for each model
        switch OPTIONS.modelname           
            case 'MODEL1'    % no adaxial and abaxial domains
                
            case {'MODEL2','MODEL3'}  
                id_abaxial_p(m.FEnodes(:,1) > 0) = 1;
                id_adaxial_p(m.FEnodes(:,1) < 0) = 1;
            
            case 'MODEL4'
                side = [ 0.8, 0, 0.8 ];   
                RADII_SIDE = sqrt((m.FEnodes(:,1) - side(1)).^2 +...
                                  (m.FEnodes(:,2) - side(2)).^2 +...
                                  (m.FEnodes(:,3) - side(3)).^2);
                id_adaxial_p(RADII_SIDE <= 0.48) = 1;   
                id_abaxial_p(RADII_SIDE >= 0.6) = 1;
                
            case 'MODEL5' 
                side = [ 0.6, 0, 1 ];   
                RADII_SIDE = sqrt((m.FEnodes(:,1) - side(1)).^2 +...
                                  (m.FEnodes(:,2) - side(2)).^2 +...
                                  (m.FEnodes(:,3) - side(3)).^2);
                id_adaxial_p((RADII_SIDE <= 0.5)|...
                             ((abs(m.FEnodes(:,2)) <= 0.02)&...   
                              (m.FEnodes(:,1) > 0.3)...
                             )...
                            ) = 1;
                id_abaxial_p((RADII_SIDE >= 0.6)&...
                             ((abs(m.FEnodes(:,2)) > 0.1)|...
                              (m.FEnodes(:,1) < 0.25)...
                             )...
                            ) = 1;
                        
        end
         
        % adaxial domain generate a diffusible singal S_ADAXIAL
        s_adaxial_p = id_adaxial_p;
        m.morphogenclamp( (id_adaxial_p == 1), s_adaxial_i ) = 1;
        m = leaf_mgen_conductivity( m, 'S_ADAXIAL', 0.05 );
        m = leaf_mgen_absorption( m, 'S_ADAXIAL', 0.01 );
        
        % abaxial domain generate a diffusible singal S_ABAXIAL
        s_abaxial_p = id_abaxial_p;
        m.morphogenclamp((id_abaxial_p == 1), s_abaxial_i) = 1;
        m = leaf_mgen_conductivity( m, 'S_ABAXIAL', 0.05 );
        m = leaf_mgen_absorption( m, 'S_ABAXIAL', 0.01 );

        % midplane domain is activated where both the signals fell below a threshold value
        id_midplane_p((s_adaxial_p < 0.9) & (s_abaxial_p < 0.9)) = 1;
     
        % setup the proximal and distal domains
        switch OPTIONS.modelname              
            case 'MODEL4'
                tip = [ 0.35, 0, 0.9 ];
                
            otherwise
                tip = [ 0, 0, 1 ];               
        end
 
        v_tip_p = sqrt((m.FEnodes(:,1) - tip(1)).^2 +...
                       (m.FEnodes(:,2) - tip(2)).^2 +...
                       (m.FEnodes(:,3) - tip(3)).^2);
        id_prox_p( m.FEnodes(:,3) == min(m.FEnodes(:,3)) ) = 1;
        id_dist_p(v_tip_p < 0.025) = 1;
        
        v_center_p = sqrt(m.FEnodes(:,1).^2 + m.FEnodes(:,2).^2 + m.FEnodes(:,3).^2);
        id_surface_p((v_center_p > 0.95) & (~id_midplane_p)) = 1;
   
        % base of mesh was fixed at the X-Y plane
        m = leaf_fix_vertex( m, 'vertex', find(m.FEnodes(:,3) == min(m.FEnodes(:,3))), 'dfs', 'z');
        
        % plotting morphogens 
        switch OPTIONS.modelname      
            case 'MODEL1' 
                m = leaf_plotoptions( m, 'morphogen', { 'id_prox', 'id_dist' });
                m = leaf_plotpriority( m, { 'id_prox', 'id_dist' }, [ 1, 1 ], [ 0.5, 0.5 ], 'type', 'morphogen' );
                                  
            otherwise
                m = leaf_plotoptions( m, 'morphogen', { 'id_adaxial', 'id_abaxial', 'id_midplane' });
                m = leaf_plotpriority( m, { 'id_adaxial', 'id_abaxial', 'id_midplane' },...
                                          [ 1, 1, 2 ], [ 0.5, 0.5, 0.5 ], 'type', 'morphogen' );
        end

    end
    
    % @@ PRN Polarity Regulatory Network
    % Pre-growth stage for generating the polarity field
    
    if (realtime <= 1 - 0.001)  
        
        % The orthoplanar polarity field was established by a diffusible morphogen POL
        % generated by a source at the surface and removed at a sink at the midplane
        switch OPTIONS.modelname
            case 'MODEL1'
                pol_p=0;    % no orthoplanar polarity field
            
            otherwise
                pol_p = id_surface_p - id_midplane_p;
                m.morphogenclamp((id_surface_p == 1)|(id_midplane_p == 1), pol_i) = 1;
                m = leaf_mgen_conductivity( m, 'POL', 0.1 );
                m = leaf_mgen_absorption( m, 'POL', 0.01 );
        end
        
        % The proximodistal polarity field was established by a diffusible morphogen POL2
        % generated by a source at the base and removed at a sink at the tip
        pol2_p = id_prox_p - id_dist_p;   
        m.morphogenclamp((id_prox_p == 1)|(id_dist_p == 1), pol2_i) = 1;
        m = leaf_mgen_conductivity( m, 'POL2', 0.1 );
        m = leaf_mgen_absorption( m, 'POL2', 0.01 );                
    end

    % @@ KRN Growth Rate Regulatory Network
    % kpar: growth rate paralle to the orthoplanar polarity field (Kop in the text)
    % kpar2: growth rate paralle to the proximodistal polarity field (Kpd in the text)
    % kper: growth rate perpendicular to both polarity fields (Kper in the text)

    if (realtime > 1 - 0.001) && (realtime <= 12 - 0.001)  % Each model running for 12 time units
       
        switch OPTIONS.modelname   
            case 'MODEL1'
                kpar_p = 0.001;  
                kpar2_p = 0.25;  
                kper_p = 0.001;
                
            case {'MODEL2','MODEL4','MODEL5'}
                kpar_p = 0.001;
                kpar2_p = 0.25;
                kper_p = 0.2;
                
            case 'MODEL3'
                kpar_p = 0.001;
                kpar2_p = 0.25;  
                kper_p = 0.05;     % reduced kper
            
        end

    end
%%% END OF USER CODE: MORPHOGEN INTERACTIONS

%%% SECTION 3: INSTALLING MODIFIED VALUES BACK INTO MESH STRUCTURE
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.

    m.morphogens(:,kpar_i) = kpar_p;
    m.morphogens(:,kpar2_i) = kpar2_p;
    m.morphogens(:,kper_i) = kper_p;
    m.morphogens(:,pol_i) = pol_p;
    m.morphogens(:,pol2_i) = pol2_p;
    m.morphogens(:,id_adaxial_i) = id_adaxial_p;
    m.morphogens(:,id_abaxial_i) = id_abaxial_p;
    m.morphogens(:,id_midplane_i) = id_midplane_p;
    m.morphogens(:,id_surface_i) = id_surface_p;
    m.morphogens(:,id_base_i) = id_base_p;
    m.morphogens(:,s_adaxial_i) = s_adaxial_p;
    m.morphogens(:,s_abaxial_i) = s_abaxial_p;
    m.morphogens(:,v_center_i) = v_center_p;
    m.morphogens(:,v_radii_i) = v_radii_p;
    m.morphogens(:,id_prox_i) = id_prox_p;
    m.morphogens(:,id_dist_i) = id_dist_p;
    m.morphogens(:,v_dist_i) = v_dist_p;
    m.morphogens(:,v_tip_i) = v_tip_p;

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

% The GFtbox_..._Callback routines can be deleted if you do not use them.
% Those that you retain will be automatically called by GFtbox at certain
% points in the simulation cycle.
% If you retain them, their headers specifying their arguments and results
% must not be altered.

function [m,result] = GFtbox_Precelldivision_Callback( m, ci ) %#ok<DEFNU>
    result = [];
    % Your code here.

    % If a nonempty result is to be returned, it should be a struct
    % with fields result.divide, result.dividepoint, and result.perpendicular.
end

function [m,result] = GFtbox_Postcelldivision_Callback( m, ci, cei, newci, newcei, oe1, oe2, ne1, ne2, ne3 ) %#ok<DEFNU>
    result = [];
    % Your code here.
end

function [m,result] = GFtbox_Postiterate_Callback( m ) %#ok<DEFNU>
    result = [];
    % Your code here.
end

function [m,result] = GFtbox_Preplot_Callback( m, theaxes ) %#ok<DEFNU>
    result = [];
    % Your code here.
end

function [m,result] = GFtbox_Postplot_Callback( m, theaxes ) %#ok<DEFNU>
    result = [];
    % Your code here.
end