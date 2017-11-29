(function($) {
    $.fn.orgChart = function(options) {
        var opts = $.extend({}, $.fn.orgChart.defaults, options);
        return new OrgChart($(this), opts);        
    }

    $.fn.orgChart.defaults = {
        data: [{id:1, name:'Root', parent: 0}],
        showControls: false,
        allowEdit: false,
        onAddNode: null,
        onDeleteNode: null,
        onClickNode: null,
        newNodeText: 'Add Child'
    };

    function OrgChart($container, opts){
        var data = opts.data;
        var nodes = {};
        var rootNodes = [];
        this.opts = opts;
        this.$container = $container;
        var self = this;

        this.draw = function(){
            $container.empty().append(rootNodes[0].render(opts));
            $container.find('.node').click(function(){							//클릭 이벤트
                if(self.opts.onClickNode !== null){
                    self.opts.onClickNode(nodes[$(this).attr('node-id')]);
                }
            });

            if(opts.allowEdit){													//수정 옵션 일때
                $container.find('i[name=org-edit-button]').click(function(e){	//수정 아이콘 클릭	
                    var thisId = $(this).parent().parent().attr('node-id');		//만약 기존CSS 에 부모가 추가되거나 제거되면, 수정해줘야함!! 
                   
                    self.startEdit(thisId);										//편집 세팅 함수 input text 생성
                    e.stopPropagation();
                });
            }

            // add "add button" listener
            $container.find('i[name=org-add-button]').click(function(e){		//추가 버튼 클릭
                var thisId = $(this).parent().parent().attr('node-id');			//만약 기존CSS 에 부모가 추가되거나 제거되면, 수정해줘야함!! 

                if(self.opts.onAddNode !== null){								//사실상.. 타는경우 못봄...?? (기존 구현되있엇음 )
                	self.opts.onAddNode(nodes[thisId]);
                }
                else{
                    self.newNode(thisId);										//새로운 노드 추가 그리드 데이터 세팅 
                }
                e.stopPropagation();
            });

            $container.find('i[name=org-del-button]').click(function(e){		//삭제 버튼 클릭 
                var thisId = $(this).parent().parent().attr('node-id');			//만약 기존CSS 에 부모가 추가되거나 제거되면, 수정해줘야함!! 
                
                if(self.opts.onDeleteNode !== null){							//사실상.. 타는경우 못봄...?? (기존 구현되있엇음 )
                    self.opts.onDeleteNode(nodes[thisId]);
                }
                else{
                    self.deleteNode(thisId);									//기존 노드 삭제 
                }
                e.stopPropagation();
            });
            
            $container.find('#cancelBtn').click(function(){						//신규 노드 에서 취소버튼 이벤트
            	 self.removeNewNode();
            });
        }
        
        //기존노드 수정하기 (text 만)
        this.startEdit = function(id){
        	
        	if(nodes[0] != undefined){		//기존 노드 수정시 신규로 추가 시켰던 노드 그리드 삭제.
        		nodes[nodes[0].data.parent].removeChild(0);
        		delete nodes[0];
                self.draw();
        	}
        	
            var inputElement = $('<input class="input_s_b mgt10 w100pro" id="inputViewName'+id+'" type="text" value="'+nodes[id].data.name+'"/>');
            $container.find('div[node-id='+id+'] font').replaceWith(inputElement);		//태그 변환
            
            var commitChange = function(){
               fnObj.doSaveNode(id,'');			//jsp 페이지에 신규노드(새로운 조직도) DB 저장 
            }  
            inputElement.focus();
            inputElement.keyup(function(event){
                if(event.which == 13){			//엔터키 누를때 이벤트
                    commitChange();
                }
                /*else{
                    nodes[id].data.name = inputElement.val();
                }*/
            });
            inputElement.blur(function(event){	//포커스 아웃시 이벤트
                commitChange();
            })
        }
        
        //신규 노드 추가 
        this.newOrgNode = function(id){
        	
        	$(".editBtnArea").hide();
        	//회사 선택 셀렉트 박스 생성
        	var selectElement = function(){
            	
            	var companySelectObj = getCodeInfo('KOR', 'companyId', 'companyViewName', '', '회사선택', '회사선택', '/basic/getCompanyList.do', { allYn :(id == 0 ? 'Y' : '')});
            	if(companySelectObj == null){
            		companySelectObj = [{'companyId' : '' , 'companyViewName' : '등록가능 회사가 없습니다.'}];
            	}
            	return createSelectTag('companyId', companySelectObj, 'companyId', 'companyViewName', '', 'fnObj.changeCompany('+id+',$("#companyId option:selected").text());', {}, null, 'select_b w100pro');
            }
        	
        	//회사선택 셀렉트 박스
        	$container.find('div[node-id='+id+'] font').append(selectElement);	
        	//조직도 상에서 보여질 이름
        	$container.find('div[node-id='+id+'] font').append('<input class="input_s_b mgt10 w100pro" id="inputViewName'+id+'" type="text" value=""/>');	
          
        }
        
        //노드 추가 시 임시 데이터 세팅.
        this.newNode = function(parentId){
            /*var nextId = Object.keys(nodes).length;
            while(nextId in nodes){
                nextId++;
            }*/
        	self.addNode({id: '0', name: '', parent: parentId});	//노드 추가 
        }
        
        //노드 추가 
        this.addNode = function(data){
            var newNode = new Node(data);
            nodes[data.id] = newNode;
            nodes[data.parent].addChild(newNode);

            self.draw();
            //self.startEdit(data.id);
            self.newOrgNode(data.id);
        }

        //기존 노드 삭제 
        this.deleteNode = function(id){
            
        	if(nodes[id].children.length>0){alert("하위 노드가 있을경우 삭제할 수 없습니다.");}
        	else{
        		if(confirm("해당 회사를 조직도에서 삭제하시겠습니까?")){
	        		fnObj.deleteCompanyStruct(id);
	        	}
        	}
        }

        this.getData = function(){
            var outData = [];
            for(var i in nodes){
                outData.push(nodes[i].data);
            }
            return outData;
        }
        
        //신규 추가 노드 삭제
        this.removeNewNode =function(){
        	if(nodes[0] != undefined){
        		nodes[nodes[0].data.parent].removeChild(0);
        		delete nodes[0];
                self.draw();
        	}
        	
        }

        // constructor
        for(var i in data){
            var node = new Node(data[i]);
            nodes[data[i].id] = node;
        }

        // generate parent child tree
        for(var i in nodes){
            if(nodes[i].data.parent == 0){
                rootNodes.push(nodes[i]);
            }
            else{
                nodes[nodes[i].data.parent].addChild(nodes[i]);
            }
        }

        // draw org chart
        $container.addClass('orgChart');
        self.draw();
    }

    function Node(data){
        this.data = data;
        this.children = [];
        var self = this;

        this.addChild = function(childNode){
            this.children.push(childNode);
        }

        this.removeChild = function(id){
            for(var i=0;i<self.children.length;i++){
                if(self.children[i].data.id == id){
                    self.children.splice(i,1);
                    return;
                }
            }
        }

        this.render = function(opts){
            var childLength = self.children.length,
                mainTable;

            mainTable = "<table cellpadding='0' cellspacing='0' border='0'>";
            var nodeColspan = childLength>0?2*childLength:2;
            mainTable += "<tr><td colspan='"+nodeColspan+"'>"+self.formatNode(opts)+"</td></tr>";

            if(childLength > 0){
                var downLineTable = "<table cellpadding='0' cellspacing='0' border='0'><tr class='lines x'><td class='line left half'></td><td class='line right half'></td></table>";
                mainTable += "<tr class='lines'><td colspan='"+childLength*2+"'>"+downLineTable+'</td></tr>';

                var linesCols = '';
                for(var i=0;i<childLength;i++){
                    if(childLength==1){
                        linesCols += "<td class='line left half'></td>";    // keep vertical lines aligned if there's only 1 child
                    }
                    else if(i==0){
                        linesCols += "<td class='line left'></td>";     // the first cell doesn't have a line in the top
                    }
                    else{
                        linesCols += "<td class='line left top'></td>";
                    }

                    if(childLength==1){
                        linesCols += "<td class='line right half'></td>";
                    }
                    else if(i==childLength-1){
                        linesCols += "<td class='line right'></td>";
                    }
                    else{
                        linesCols += "<td class='line right top'></td>";
                    }
                }
                mainTable += "<tr class='lines v'>"+linesCols+"</tr>";

                mainTable += "<tr>";
                for(var i =0;i<self.children.length;i++){
                    mainTable += "<td colspan='2'>"+self.children[i].render(opts)+"</td>";
                }
                mainTable += "</tr>";
            }
            mainTable += '</table>';
            return mainTable;
        }

        this.formatNode = function(opts){
            var nameString = '',
                descString = '';
            if(typeof data.name !== 'undefined'){
                nameString = '<font>'+self.data.name+'</font>';
            }
            if(typeof data.description !== 'undefined'){
                descString = '<p>'+self.data.description+'</p>';
            }
            if(opts.showControls){
            	
                if(self.data.id != 0){		//신규가 아닌 기존 노드
                	//첫번째 노드가 아닐때
                	if(self.data.parent != 0) var buttonsHtml = "<div class='editBtnArea' style='margin-top: 10px;'><i class='axi axi-plus-circle' name='org-add-button'></i><i class='axi axi-edit mgl10' name='org-edit-button' ></i><i class='axi axi-minus-circle mgl10' name='org-del-button'></i></div>";
                	//첫번째 노드일때 
                	else var buttonsHtml = "<span class='editBtnArea'><i class='axi axi-plus-circle' name='org-add-button'></i><i class='axi axi-edit' name='org-edit-button' ></i></span>";
                }
                else var buttonsHtml = "<div><a name='doSaveBtn' class='btn_g_black mgt10' href='javascript:fnObj.doSaveNode("+self.data.id+","+self.data.parent+");'>저장</a><a id='cancelBtn' class='btn_g_black mgl10 mgt10'>취소</a></div>";
            }
            else{
                buttonsHtml = '';
            }
            return "<div style='cursor:pointer;' class='node' node-id='"+this.data.id+"'>"+nameString+descString+buttonsHtml+"</div>";	/* style='cursor:pointer;' 20170119 */
        }
        
        
    }

})(jQuery);

