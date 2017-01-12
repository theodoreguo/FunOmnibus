//
//  TGCommentHeaderView.m
//  MyWeibo
//
//  Created by Theodore Guo on 11/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGCommentHeaderView.h"

@interface TGCommentHeaderView ()

// Title label
@property (nonatomic, weak) UILabel *label;

@end

@implementation TGCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = TGGlobalBackgroundColor;
        
        // Create label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = TGRGBColor(67, 67, 67);
        label.width = 200;
        label.x = TGPostCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.label.text = title;
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    
    TGCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) { // Not available in buffer pool, create new header
        header = [[TGCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
}

@end
